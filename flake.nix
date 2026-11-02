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
      version = "131";

      src = pkgs.fetchurl {
        url = "https://github.com/Djihads80/Eglantine/releases/download/build-131/eglantine-ce1b1de6f1beed36958368f89cda466937ff9716-linux-x86_64-pgo.AppImage";
        hash = "sha256-wESxkF/XZKJSWuUOHc4Fg8iV7gBa1AoKRbfv4ifmxF4=";
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
