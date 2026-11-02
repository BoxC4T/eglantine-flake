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
          libGL
          vulkan-loader
          libusb1
          libxkbcommon
          wayland
          libx11
          libxcb
          libxext
          libxrandr
          libxrender
          libxi
          libxcursor
          libxfixes
          libxinerama
          libxscrnsaver
          alsa-lib
          udev
        ];

      extraInstallCommands = ''
        mkdir -p $out/share/applications
        mkdir -p $out/share/icons/hicolor

        if [ -d $out/share/icons ]; then
          cp -r $out/share/icons/* $out/share/icons/hicolor/ 2>/dev/null || true
        fi
      '';
    };
  in {
    packages.${system} = {
      default = eglantine;
      eglantine = eglantine;
    };

    apps.${system}.default = {
      type = "app";
      program = "${eglantine}/bin/eglantine";
    };

    apps.${system}.eglantine = self.apps.${system}.default;
  };
}
