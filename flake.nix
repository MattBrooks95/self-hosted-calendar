{
  description = "self hosted calendar app";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem(system:
    let pkgs = nixpkgs.legacyPackages.${system};
      calendar-frontend = (with pkgs; stdenv.mkDerivation {
        buildPhase = ''
        '';
        installPhase = ''
        '';
      });
      calendar-backend = (with pkgs; stdenv.mkDerivation {
        pname = "calendar-backend";
        version = "0.0.1";
        buildPhase = ''
        '';
        installPhase = ''
        '';
      });
    in {
      packages.default = calendar-backend;
      apps.default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/calendar";
      };
      devShell = (with pkgs; mkShell {
        buildInputs = [
          elmPackages.elm
          elmPackages.elm-language-server
        ];
      });
    }
  );
}
