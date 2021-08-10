#!/bin/bash
#
# Command to generate: argbash .svgz2png.sh -o make-gif
#
# ARG_OPTIONAL_SINGLE([tmp-file], [t], [Enable verbose output], "/tmp/tmp.svg")

# ARG_POSITIONAL_SINGLE([in-file], [Input file.], )
# ARG_POSITIONAL_SINGLE([out-file], [Output file.], "/tmp/out.png")

# ARG_HELP([SVGZ to PNG])

# ARGBASH_GO

# [ <-- needed because of Argbash

set -ex

IN_FILE="${_arg_in_file}"
OUT_FILE="${_arg_out_file}"
TMP_FILE="${_arg_tmp_file}"

gzip -cdf "${IN_FILE}" -S gz > "${TMP_FILE}"
inkscape \
    --batch-process \
    --actions="FitCanvasToDrawing;FileSave;export-filename:${OUT_FILE};export-do;FileClose" \
    "${TMP_FILE}" 2>/dev/null
rm "${TMP_FILE}"

# ] <-- needed because of Argbash

