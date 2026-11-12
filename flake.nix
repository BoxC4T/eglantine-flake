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
      version = "branch-nx2-experimental-efb9fb18";

      src = pkgs.fetchurl {
        url = "https://github.com/Eglantine-Community/Eglantine/releases/download/branch-nx2-experimental-efb9fb18/eglantine-linux-x86_64-pgo.AppImage";
        hash = "sha256-86ahB3BCjn8jKV9bgAnlJ/u8nkleB2ftNCupnxv+dZw=";
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
