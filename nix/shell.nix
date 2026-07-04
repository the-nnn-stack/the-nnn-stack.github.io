{
  perSystem = {pkgs, ...}: {
    devShells.default = let
      packages = with pkgs; [
        git

        bun
      ];

      libraries = with pkgs; [
        pkg-config
      ];
    in
      with pkgs;
        mkShell {
          name = "nnn-stack-website";
          buildInputs = packages ++ libraries;

          DIRENV_LOG_FORMAT = "";
          LD_LIBRARY_PATH = "${lib.makeLibraryPath libraries}:$LD_LIBRARY_PATH";
        };
  };
}
