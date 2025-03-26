{ pkgs ? import <nixpkgs> {}, ... }: 
pkgs.mkShell {
  env.LIBCLANG_PATH = "${pkgs.libclang.lib}/lib/libclang.so";
  packages = [
    pkgs.cmake
    pkgs.clang
    pkgs.rustup
  ];
  shellHook = ''
    ulimit -n 2048
  '';
}
