{
  description = "C++ development environment with clang 19";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShells.default = pkgs.mkShell {
        name = "cpp-dev-shell";

        # Development tools
        buildInputs = with pkgs; [
          clang_19 # Clang 19 compiler
          clang-tools_19 # Clang tools (includes clangd)
          # cmake             # Build system
          # ninja             # Build tool
          # gdb               # Debugger
        ];

        # Shell hook to generate .clangd file
        shellHook = ''
          cat > .clangd << EOF
          CompileFlags:
            Add:
              - "-I${pkgs.libcxx.dev}/include/c++/v1"  # C++ standard library headers
              - "-I${pkgs.glibc.dev}/include"          # C standard library headers
          EOF
        '';
      };
    });
}
