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
      version = "v0.1.0-rc1";

      src = pkgs.fetchurl {
        url = "https://github.com/Djihads80/Eglantine/releases/download/v0.1.0-rc1/eglantine-linux-x86_64-pgo.AppImage";
        hash = "sha256-2gTok05YCPUhnc4rKZu+qZw+56gKPWbTpg2R3y51rCk=";
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
