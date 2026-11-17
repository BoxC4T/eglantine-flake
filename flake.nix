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
      version = "daily-20261117";

      src = pkgs.fetchurl {
        url = "https://github.com/Eglantine-Community/Eglantine/releases/download/daily-20261117/eglantine-linux-x86_64-pgo.AppImage";
        hash = "sha256-lm3mPGRvKmer2YQF4+37CY/vgaBAYwEC5Tjb3/jzZbc=";
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
