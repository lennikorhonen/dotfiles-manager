{ pkgs, config }:

pkg:

let
  nixGL = import <nixgl> {};
in
(pkg.overrideAttrs (old: {
  name = "nixGL-${pkg.name}";

  buildCommand = ''
    set -eo pipefail

    ${
      pkgs.lib.concatStringsSep "\n" (map (outputName: ''
        echo "Copying output ${outputName}"
        set -x
        cp -rs --no-preserve=mode "${pkg.${outputName}}" "''$${outputName}"
        set +x
      '') (old.outputs or [ "out" ]))}

      rm -rf $out/bin/*
      shopt -s nullglob
      for file in ${pkg.out}/bin/*; do
        echo "#!${pkgs.bash}/bin/bash" > "$out/bin/$(basename $file)"
        echo "exec -a \"\$0\" ${nixGL.auto.nixGLDefault}/bin/nixGL $file \"\$@\"" >> "$out/bin/$(basename $file)"
        chmod +x "$out/bin/$(basename $file)"
      done
      shopt -u nullglob
    '';
  })
)
