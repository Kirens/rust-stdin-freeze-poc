{
  inputs = {
    nixpkgs_62.url = github:NixOS/nixpkgs/762b003329510ea855b4097a37511eb19c7077f0;
    nixpkgs_63.url = github:NixOS/nixpkgs/b784c5ae63dd288375af1b4d37b8a27dd8061887;
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs_62, nixpkgs_63, flake-utils }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = n: n.legacyPackages.${system};
      in rec {
        devShells.old = with pkgs nixpkgs_62; mkShell {
          nativeBuildInputs = [ rustc cargo ];
        };
        devShells.new = with pkgs nixpkgs_63; mkShell {
          nativeBuildInputs = [ rustc cargo ];
        };
      }
    );
}
