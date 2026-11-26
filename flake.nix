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
      version = "daily-20261125";

      src = pkgs.fetchurl {
        url = "https://github.com/Eglantine-Community/Eglantine/releases/download/daily-20261125/eglantine-linux-x86_64-pgo.AppImage";
        hash = "sha256-U6eyhQFwmbjk5a9nJDDvYKWyEuCvEH4AUN0Ww6b9ZA4=";
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
