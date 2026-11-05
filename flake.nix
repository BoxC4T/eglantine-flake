{
  description = "Eglantine emulator AppImage packaged for NixOS";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    eglantine = pkgs.appimageTools.wrapType2 {
      pname = "eglantine";
      version = "branch-switchbrew-names-736c1d29";

      src = pkgs.fetchurl {
        url = "https://github.com/Djihads80/Eglantine/releases/download/branch-switchbrew-names-736c1d29/eglantine-linux-x86_64-pgo.AppImage";
        hash = "sha256-gElXDzi6c8T5/oB+dpwaOWdRh6i5FWFOAfCPY7lwYWg=";
      };
      extraPkgs = pkgs:
        with pkgs; [
          libgpg-error
        ];
    };
  in {
    packages.${system} = {
      default = eglantine;
    };

    apps.${system} = {
      default = {
        type = "app";
        program = "${eglantine}/bin/eglantine";
      };
    };
  };
}
