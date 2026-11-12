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
      version = "branch-updater-tester-builds-b7704dc8";

      src = pkgs.fetchurl {
        url = "https://github.com/Eglantine-Community/Eglantine/releases/download/branch-updater-tester-builds-b7704dc8/eglantine-linux-x86_64.AppImage";
        hash = "sha256-U5qWbdZnuo92l+78BkEGG9hohOPn6yfduPxgbM8ddhI=";
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
