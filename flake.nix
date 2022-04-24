{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    easy-purescript-nix = {
      url = "github:justinwoo/easy-purescript-nix";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, easy-purescript-nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        easy-ps = import easy-purescript-nix { inherit pkgs; };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            easy-ps.purs-0_14_7
            easy-ps.psc-package
            easy-ps.spago
            easy-ps.purty
            easy-ps.zephyr
            pkgs.nodejs
            pkgs.dhall-lsp-server
          ];
        };
      });
}
