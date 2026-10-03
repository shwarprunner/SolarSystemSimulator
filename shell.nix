{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    julia
    gcc
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="/run/opengl-driver/lib:${pkgs.gcc.cc.lib}/lib:$LD_LIBRARY_PATH"
    export JULIA_PROJECT=.
  '';
}
