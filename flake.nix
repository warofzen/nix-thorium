{
  description = "Thorium using Nix Flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
    ...
  }: {
    ##### x86_64-linux #####
    packages.x86_64-linux = let
      pkgs = import nixpkgs {system = "x86_64-linux";};
    in {
      thorium-avx = let
        pkgs = import nixpkgs {system = "x86_64-linux";};
        name = "thorium-avx";
        version = "122.0.6261.132 - 56";
        src = pkgs.fetchurl {
          url = "https://github.com/Alex313031/thorium/releases/download/M123.0.6312.133/Thorium_Browser_123.0.6312.133_AVX.AppImage";
          sha256 = "sha256-JBbpQLXp4jxDb7/BH4SmH7wIPoXdAsZgc+6cFcGriWg=";
        };
        appimageContents = pkgs.appimageTools.extractType2 {inherit name src;};
      in
        pkgs.appimageTools.wrapType2 {
          inherit name version src;
          extraInstallCommands = ''
            install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
            install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
            substituteInPlace $out/share/applications/thorium-browser.desktop \
            --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
          '';
        };

      thorium-avx2 = let
        pkgs = import nixpkgs {system = "x86_64-linux";};
        name = "thorium-avx2";
        version = "122.0.6261.132 - 56";
        src = pkgs.fetchurl {
          url = "https://github.com/Alex313031/thorium/releases/download/M123.0.6312.133/Thorium_Browser_123.0.6312.133_AVX2.AppImage";
          sha256 = "sha256-PhFJD9AhSYczakAsPspPtCw21XUxqldr+HkxNqbgs/s=";
        };
        appimageContents = pkgs.appimageTools.extractType2 {inherit name src;};
      in
        pkgs.appimageTools.wrapType2 {
          inherit name version src;
          extraInstallCommands = ''
            install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
            install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
            substituteInPlace $out/share/applications/thorium-browser.desktop \
            --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
          '';
        };

      thorium-sse3 = let
        pkgs = import nixpkgs {system = "x86_64-linux";};
        name = "thorium-sse3";
        version = "122.0.6261.132 - 56";
        src = pkgs.fetchurl {
          url = "https://github.com/Alex313031/thorium/releases/download/M123.0.6312.133/Thorium_Browser_123.0.6312.133_SSE3.AppImage";
          sha256 = "sha256-cP8PiGwscVg29Rn2WpazqGZuS6aLIW9WjmZhcsWUSUU=";
        };
        appimageContents = pkgs.appimageTools.extractType2 {inherit name src;};
      in
        pkgs.appimageTools.wrapType2 {
          inherit name version src;
          extraInstallCommands = ''
            install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
            install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
            substituteInPlace $out/share/applications/thorium-browser.desktop \
            --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
          '';
        };

      # AVX is compatible with most CPUs
      default = self.packages.x86_64-linux.thorium-avx;
    };

    apps.x86_64-linux = {
      thorium-avx = {
        type = "app";
        program = "${self.packages.x86_64-linux.thorium-avx}/bin/thorium-avx";
      };

      thorium-avx2 = {
        type = "app";
        program = "${self.packages.x86_64-linux.thorium-avx2}/bin/thorium-avx2";
      };

      thorium-sse3 = {
        type = "app";
        program = "${self.packages.x86_64-linux.thorium-sse3}/bin/thorium-sse3";
      };

      default = self.apps.x86_64-linux.thorium-avx;
    };

    ##### aarch64-linux #####
    packages.aarch64-linux = {
      thorium = let
        pkgs = import nixpkgs {system = "aarch64-linux";};
        name = "thorium";
        version = "122.0.6261.132 - 6";
        src = pkgs.fetchurl {
          url = "https://github.com/Alex313031/Thorium-Raspi/releases/download/M123.0.6312.133/Thorium_Browser_123.0.6312.133_arm64.AppImage";
          sha256 = "sha256-9lSVOsiMjpxAK9/nNBVgxUPqwPyeAFDOKSab/sSNGho=";
        };
        appimageContents = pkgs.appimageTools.extractType2 {inherit name src;};
      in
        pkgs.appimageTools.wrapType2 {
          inherit name version src;
          extraInstallCommands = ''
            install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
            install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
            substituteInPlace $out/share/applications/thorium-browser.desktop \
            --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
          '';
        };

      default = self.packages.aarch64-linux.thorium;
    };

    apps.aarch64-linux = {
      thorium = {
        type = "app";
        program = "${self.packages.aarch64-linux.thorium}/bin/thorium";
      };

      default = self.apps.aarch64-linux.thorium;
    };
  };
}
