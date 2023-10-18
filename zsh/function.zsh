# Function
texbuild() {
    filename=`echo $1 | cut -d "." -f 1`
    docker run --rm -it -v $(pwd):/workdir paperist/alpine-texlive-ja \
        sh -c "uplatex $1 ;dvipdfmx  $filename.dvi"
    rm $filename.dvi $filename.log -f
}


mark2pdf(){
    filename=`echo $1 | cut -d "." -f 1`
    docker run --rm -v $(pwd):/data frozenbonito/pandoc-eisvogel-ja:plantuml \
    --listings \
    -N \
    --toc \
    -V linkcolor=blue \
    -V table-use-row-colors=true \
    -V titlepage=true \
    -V toc-own-page=true \
    -V toc-title="目次" \
    -o $filename.pdf \
    $filename.md
}


# popd / pushd
pushd () {
    builtin pushd "$@" > /dev/null
}

popd () {
    builtin popd "$@" > /dev/null
}
export pushd popd

# Notify
term-notify() {
    iconPath=`find /usr/share/icons | grep $TERM | head -1`
    notify-send -i ${iconPath} $1 -t 5
}

nix-patch() {
    filetype=$(file -i $1)
    if [[ ! $(echo $filetype  | grep "binary") ]]; then
        echo "This file is not Binary file."
        return 1
    fi
    nix-shell -p patchelf \
        --run 'patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $1'
}
