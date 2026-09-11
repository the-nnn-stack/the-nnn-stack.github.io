{
  perSystem = {pkgs, ...}: {
    packages.default = pkgs.runCommand "nnn-stack-site" {} ''
      mkdir -p $out
      cp ${../index.html}   $out/index.html
      cp ${../style.css}    $out/style.css
      cp ${../app.js}       $out/app.js
      cp ${../members.json} $out/members.json
    '';
  };
}
