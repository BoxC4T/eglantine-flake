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
      version = "branch-fix-oot-blackscreen-17ac56ed";

      src = pkgs.fetchurl {
        url = "https://github.com/Djihads80/Eglantine/releases/download/branch-fix-oot-blackscreen-17ac56ed/eglantine-linux-x86_64.AppImage";
        hash = "sha256-u5n0Fa2n0OoF1a9qrBh+IYS5vQq/4lnbxxtXg85mpzw=";
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
