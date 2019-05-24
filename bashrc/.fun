#!/usr/bin/env bash

function copy(){
	echo -n $@ | xclip -selection clipboard
}

function finddev(){
	for sysdevpath in $(find /sys/bus/usb/devices/usb*/ -name dev); do
		(
			syspath="${sysdevpath%/dev}"
			devname="$(udevadm info -q name -p $syspath)"
			[[ "$devname" == "bus/"* ]] && continue
			eval "$(udevadm info -q property --export -p $syspath)"
			[[ -z "$ID_SERIAL" ]] && continue
			echo "/dev/$devname - $ID_SERIAL"
		)
	done
}

function wsdims(){
	if [[ "$#" -ne 2 ]]; then
		echo "USAGE : ${FUNCNAME[0]} <width> <height>";
		return -1;
	else
		gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize $1
		gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize $2
	fi
}

function nwmount(){
	nwroot="${HOME}/Miscellaneous/NWdrive"
	mkdir -p "${nwroot}/sandbox"
	mkdir -p "${nwroot}/public"
	mkdir -p "${nwroot}/ycho"
	mkdir -p "${nwroot}/research"
	sudo mount "//fsvs01/Research" ${nwroot}/research -o user=ycho,workgroup=olin.edu,uid=jamiecho
	sudo mount "//fsvs01/Sandbox" ${nwroot}/sandbox -o user=ycho,workgroup=olin.edu,uid=jamiecho
	sudo mount "//fsvs01/Public" ${nwroot}/public -o user=ycho,workgroup=olin.edu,uid=jamiecho
	sudo mount "//FSVS01/Users/Students/2019/ycho" ${nwroot}/ycho -o user=ycho,workgroup=olin.edu,uid=jamiecho
}

function nwumount(){
	nwroot="${HOME}/Miscellaneous/NWdrive"
	sudo umount ${nwroot}/research
	sudo umount ${nwroot}/sandbox
	sudo umount ${nwroot}/public
	sudo umount ${nwroot}/ycho
}

function pykill(){
	kill $(ps -ef | grep $1 | grep python | awk '{print $2}')
}

function pycd(){
	if [[ "$#" -eq 1 ]]; then
		cd $(python -c "import $1; print $1.__path__[0]")
	else
		echo "Invalid Arguments!"
	fi
}

function watermark(){
	if [[ -d "$1" ]]; then
		echo "processing directory : $1"
		pushd $1
		mkdir -p marked
		for f in *; do
			composite -dissolve 30% -gravity southeast ~/Documents/watermark.png "$f" "marked/$f"
		done

		popd
	else
		local outfile='/tmp/marked.png'
		if [ -f "$1" ]; then
			echo $2
			if [ ! -z "$2" ]; then
				outfile=$2
			else
				read -p 'specify output file:' outfile
			fi
			echo "output file : $outfile"
			composite -dissolve 30% -gravity southeast ~/Documents/watermark.png "$1" "$outfile"
		fi
	fi
}

function list-rosdeps(){
	src="$1"
	d0="$PWD"
	echo "inspecting package $src"
	roscd "$src"
	for pkg in $(rospack list | awk '{print $1}'); do
		cnt=$(grep -hrIc $pkg . --exclude-dir=".git" | paste -sd+ | bc)
		if [ "$cnt" -gt "0" ]; then
			echo $pkg $cnt
		fi
	done
	cd "$d0"
}

function ogv2gif(){
    inputFile=$1
    FPS=30.0
    WIDTH=640

	if [[ "$#" -ge 2 ]]; then
        FPS=$2
    fi

	if [[ "$#" -ge 3 ]]; then
        WIDTH=$3
    fi

    echo "input : $inputFile fps : $FPS width : $WIDTH"

    ##Generate palette for better quality
    ffmpeg -i $inputFile -vf fps=$FPS,scale=$WIDTH:-1:flags=lanczos,palettegen tmp_palette.png

    ##Generate gif using palette
    ffmpeg -i $inputFile -i tmp_palette.png -loop 0 -filter_complex "fps=$FPS,scale=$WIDTH:-1:flags=lanczos[x];[x][1:v]paletteuse" output.gif

    rm tmp_palette.png
}

function gzkill(){
	killall -9 gazebo gzserver gzclient
}

function echo-latest-file(){
    unset -v latest
    d="$PWD"

	if [[ "$#" -eq 1 ]]; then
        d="$1"
    fi

    for file in "$d"/*; do
        [[ "$file" -nt $latest ]] && latest="$file"
    done
    echo $latest
}

function toresolve(){
	#ffmpeg -i "$1" -vcodec dnxhd -acodec pcm_s16le -s 1920x1080 -r 30000/1001 -b:v 36M -pix_fmt yuv422p -f mov "$2"
    ffmpeg -y -i "$1" -c:v mpeg4 -force_key_frames "expr:gte(t,n_forced*1)" -r ntsc-film -b:v 250000k -c:a pcm_s16le "$2"
}

function update-dotfiles(){
    local ROOT=$(dirname $(realpath "$HOME/.bashrc"))
    pushd $ROOT && git pull && popd
}
