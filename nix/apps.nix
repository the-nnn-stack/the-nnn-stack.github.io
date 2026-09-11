{self, ...}: {
  perSystem = {pkgs, ...}: {
    apps.serve = {
      type = "app";
      program = toString (
        pkgs.writeShellScript "serve" ''
          cd ${self}
          exec ${pkgs.python3}/bin/python3 -m http.server 8080
        ''
      );
    };
  };
}
