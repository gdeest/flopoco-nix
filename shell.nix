{pkgs ? import ./nixpkgs.nix {}}:

pkgs.mkShell {
  buildInputs = [ (import ./default.nix {}).flopoco ];
}
