{
  perSystem = {pkgs, ...}: {
    checks.members-json = pkgs.runCommand "check-members-json" {} ''
      ${pkgs.python3}/bin/python3 ${../check-members.py} $.../members.json}
      touch $out
    '';
  };
}
