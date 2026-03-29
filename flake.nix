{
  description = "nnn-stack website — NixOS + Niri + Noctalia";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.runCommand "nnn-stack-site" { } ''
            mkdir -p $out
            cp ${./index.html}   $out/index.html
            cp ${./style.css}    $out/style.css
            cp ${./app.js}       $out/app.js
            cp ${./members.json} $out/members.json
          '';
        }
      );

      apps = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          serve = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "serve" ''
                cd ${self}
                exec ${pkgs.python3}/bin/python3 -m http.server 8080
              ''
            );
          };
        }
      );

      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          members-json = pkgs.runCommand "check-members-json" { } ''
            ${pkgs.python3}/bin/python3 ${./check-members.py} ${./members.json}
            touch $out
          '';
        }
      );

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
