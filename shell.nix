{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    julia
    gcc
    dbeaver-bin
    fish
    cacert
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="/run/opengl-driver/lib:${pkgs.gcc.cc.lib}/lib:$LD_LIBRARY_PATH"
    export JULIA_PROJECT=.
    export SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"

    if [ -z "$FISH_VERSION" ]; then
      exec ${pkgs.fish}/bin/fish
    fi
  '';
}
