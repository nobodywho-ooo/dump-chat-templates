{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = inputs: let 
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs { inherit system; };
  in {
    packages.${system}.default = pkgs.rustPlatform.buildRustPackage {
      pname = "dump-chat-templates";
      version = "0.1.0";
      src = ./.;
      cargoLock = {
        lockFile = ./Cargo.lock;
        allowBuiltinFetchGit = true;
      };
      nativeBuildInputs = with pkgs; [
        cmake
        git
        rustPlatform.bindgenHook
      ];
    };
    devShells.${system}.default = pkgs.callPackage ./shell.nix {};
  };
}
