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
      version = "129";

      src = pkgs.fetchurl {
        url = "https://github.com/Djihads80/Eglantine/releases/download/build-129/eglantine-a407703f6d29a5ab73328b4ededb12cf29b2758d-linux-x86_64.AppImage";
        hash = "sha256-dx6xm4HIrGoCuX1v9yYPznPOc+NdIhiJNEQ2eBC9ypg=";
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
