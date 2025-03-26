{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = inputs: let 
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs { inherit system; };
    
    dumpChatTemplates = pkgs.rustPlatform.buildRustPackage {
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
    
  in {
    packages.${system}.default = dumpChatTemplates;
    
    apps.${system}.default = {
      type = "app";
      program = pkgs.lib.getExe dumpChatTemplates;
    };
    
    devShells.${system}.default = pkgs.callPackage ./shell.nix {};
  };
}
