#!/bin/bash

#-------------------------------------------------------------------------
# print success or failed with exit code depending on the input (exitcode) 
#-------------------------------------------------------------------------
print_state() {
    ec=$1
    if [ $ec -eq 0 ]; then
        echo "success"
    else
        echo "failed ($ec)"
    fi
}

#-------------------------------------------------------------------------
# resolve the dirname of the given path to its physical and absolute path.
#-------------------------------------------------------------------------
function get_abs_dirname() {
    local SOURCE=$1
    while [ -h "$SOURCE" ]; do
        # resolve $SOURCE until the file is no longer a symlink
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$(readlink "$SOURCE")"

        # if $SOURCE was a relative symlink,
        # we need to resolve it relative to the path
        # where the symlink file was located

        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done

    echo "$( cd -P "$( dirname "$SOURCE" )" && pwd )"
}

#-------------------------------------------------------------------------
# backup and make symlink in $HOME directory.
#-------------------------------------------------------------------------
setup_dotfile() {
    src=$( realpath $1 )
    dst=$( echo $src | sed "s|${REPO_PATH}|$HOME|g" )

    ## backup $dst if it presents, or remove it if a symlink
    if [ -s $dst ]; then
        echo -n "removing $dst... "
        if [ $# -eq 1 ]; then rm -f $dst; fi
        print_state $?
    elif [ -f $dst ] || [ -d $dst ]; then 
        echo -n "renaming $dst to $dst.bak... "
        if [ $# -eq 1 ]; then mv $dst $dst.bak; fi
        print_state $?
    fi

    ## make symlink
    echo -n "symlinking $src to $dst... "
    if [ $# -eq 1 ]; then ln -s $src $dst; fi
    print_state $?
}

#-------------------------------------------------------------------------
# main program starts here. 
#-------------------------------------------------------------------------
if [ $# -lt 1 ]; then
    echo "Usage: $0 dotfile1 [dotfile2] [dotfile3] [...]"
    exit 1
fi

REPO_PATH=$( get_abs_dirname $0 )

for f in ${@}; do
    setup_dotfile $f
done
