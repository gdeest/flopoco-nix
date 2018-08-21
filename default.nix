{ pkgs ? import ./nixpkgs.nix {} }:

with pkgs;

rec {
  version = "4.1.2";

  sollya = stdenv.mkDerivation rec {
      name = "sollya-4.1";

      src = fetchurl {
      url = "https://gforge.inria.fr/frs/download.php/33151/${name}.tar.gz";
        sha256 = "1phin1vwh439zbw3z6hw613r97b8mjsrihc1dsxzgdp22w5m1xzv";
      };

      buildInputs = [ fplll_20160331 gmp libxml2 mpfr mpfi ];

      enableParallelBuilding = true;
      meta = {
        homepage = http://sollya.gforce.inria.fr;
        license = stdenv.lib.licenses.cecill-c;
        description = "Sollya is a tool environment and a library for safe floating-point code development";
      };

    };

  flopoco = stdenv.mkDerivation rec {
     name = "flopoco-${version}";

      src = fetchurl {
        url = "https://gforge.inria.fr/frs/download.php/file/37213/${name}.tgz";
        sha256 = "0q1nin67ns66m0ghagwzr19ljqynjhq254rmv4gfb8mkvidbjj9i";
      };

      builder = ./builder.sh;
      buildInputs = [ bison boost flex gsl cmake libxml2 mpfi mpfr sollya ];

      enableParallelBuilding = true;

      meta = {
        homepage = http://flopoco.gforge.inria.fr;
        description = "A tool for generating arithmetic hardware operators";
      };
    };

  dockerImage = dockerTools.buildImage {
    name = "flopoco";
    tag = version;

    contents = flopoco;

    runAsRoot = ''
      #!${stdenv.shell}
      mkdir -p /data
    '';

    config = {
      EntryPoint = [ "/bin/flopoco" ];
      WorkingDir = "/data";
    };
  };
}
