import (
  let
    lock = builtins.fromJSON (builtins.readFile ../flake.lock);
    nodeName = lock.nodes.root.inputs.flake-compat;
    node = lock.nodes.${nodeName}.locked;
  in
    fetchTarball {
      url =
        node.url
        or "https://github.com/NixOS/flake-compat/archive/${node.rev}.tar.gz";
      sha256 = node.narHash;
    }
) {src = ../.;}
