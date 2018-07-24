#!/usr/bin/env bash
VERBOSE=""

function usage
{
    echo "Usage: install.sh [-h|--help]"
    echo " -h | --help      : Print this help"
}

function parse_args
{
    local _ARGS=()

    while [ "$1" ]
    do
        case "$1" in
            "-h" | "--help")
                usage
                exit 0
                ;;
        esac
        shift
    done
    
    set -- "${args[@]}"

    start_install
    exit 0
}

function start_install
{
    if [[ $EUID -ne 0 ]]; then
       printf "This script must be run as root\n" 
       exit 1
    fi

    #Put script in opt
    printf "Install sys-unconfig\n"
    WORKDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
    mkdir -p /opt/sys-unconfig
    cp -r ${WORKDIR}/* /opt/sys-unconfig
    rm -rf /usr/bin/sys-unconfig
    ln -s /opt/sys-unconfig/sys-unconfig /usr/bin/sys-unconfig
    printf "Install done\n"
}

function main
{
    parse_args "$@"
    exit 0
}

main "$@"

