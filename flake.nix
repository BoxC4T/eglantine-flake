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
      version = "178";

      src = pkgs.fetchurl {
        url = "https://github.com/Djihads80/Eglantine/releases/download/build-178/eglantine-ec667e25f9ab82ea32a10e745ff48583f63cd1d4-linux-x86_64-pgo.AppImage";
        hash = "sha256-wIUUD4IBR9NPaO1hC7NW/Gy0FLySt116kvtWMVIBPuE=";
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
