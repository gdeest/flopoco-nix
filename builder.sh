source $stdenv/setup

installPhase() {
    mkdir -p $out/bin
    cp flopoco $out/bin
}

genericBuild
