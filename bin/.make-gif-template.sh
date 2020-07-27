#!/bin/bash
#
# Command to generate: argbash .make-gif-template.sh -o make-gif
#
# ARG_OPTIONAL_BOOLEAN([verbose], [v], [Enable verbose output], off)
# ARG_OPTIONAL_BOOLEAN([interactive], [i], [Enable interactive verification], off)
# ARG_OPTIONAL_SINGLE([fps], [r], [GIF frame rate.], 30)
# ARG_OPTIONAL_SINGLE([width], [w], [GIF width, same if negative (height is computed from aspect ratio)], "-1")
# ARG_OPTIONAL_SINGLE([skip], [s], [Frame skip step size], 1)

# ARG_POSITIONAL_SINGLE([in-file], [Input file.], )
# ARG_POSITIONAL_SINGLE([out-file], [Output file.], "/tmp/output.gif")

# ARG_HELP([Generate GIF from video-like media from ffmpeg.])

# ARGBASH_GO

# [ <-- needed because of Argbash

VERBOSE="${_arg_verbose}"
INTERACTIVE="${_arg_interactive}"
FPS="${_arg_fps}"
WIDTH="${_arg_width}"
SKIP="${_arg_skip}"
INFILE="${_arg_in_file}"
OUTFILE="${_arg_out_file}"
PALETTE="/tmp/palette.png";

FFMPEG_ARGS=()
if [ ${INTERACTIVE} != "on" ]; then
    FFMPEG_ARGS+=(-y)
fi

if [ ${VERBOSE} != "on" ]; then
    FFMPEG_ARGS+=(-hide_banner)
    FFMPEG_ARGS+=(-loglevel warning)
fi

# INWIDTH="$(ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=s=x:p=0 ${INFILE})"
# WIDTH="${WIDTH-${INWIDTH--1}}"
echo "WIDTH = ${WIDTH}"

if [ ${VERBOSE} != "on" ]; then
    echo "Generating palette ...";
fi
ffmpeg -i "${INFILE}" -vf fps=${FPS},scale=${WIDTH}:-1:flags=lanczos,palettegen "${PALETTE}" "${FFMPEG_ARGS[@]}";

if [ ${VERBOSE} != "on" ]; then
    echo "Generating GIF ...";
fi
ffmpeg -i "${INFILE}" -loop 0 -i ${PALETTE} -lavfi "select='not(mod(n\,${SKIP}))',setpts=N/TB/${FPS},scale=${WIDTH}:-1:flags=lanczos,paletteuse" -r "${FPS}" "${OUTFILE}" "${FFMPEG_ARGS[@]}"

if [ ${VERBOSE} != "on" ]; then
    echo "Removing palette ..."
fi

RM_ARGS=()
if [ ${INTERACTIVE} == "on" ]; then
    RM_ARGS+=(-i)
fi
rm "${PALETTE}" "${RM_ARGS[@]}"

# ] <-- needed because of Argbash

