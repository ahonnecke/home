#!/usr/bin/env sh

# Default values for blank parameters
DEBUG=0
IN_FILE=/etc/some-input-file.conf
OUT_FILE=/var/log/some-output-file.log

# Option parser, the order doesn't matter
while [ $# -gt 0 ]; do
    case "$1" in
        -i|--input)
            IN_FILE="$2"
            shift 2
            ;;
        -o|--output)
            OUT_FILE="$2"
            shift 2
            ;;
        --debug) # Argument acting as a simple flag
            DEBUG=1
            shift 1
            ;;
        *)
            break
            ;;
    esac
done

# Some simple argument checks
wrong_arg() {
    echo "Error: invalid value for $1" >&2
    exit 2
}

[ -f $IN_FILE ] || wrong_arg "input file"
[ -f $OUT_FILE ] || wrong_arg "output file"

# The actual script can start below
# ...