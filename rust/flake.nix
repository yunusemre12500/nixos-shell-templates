{
  description = "Rust Development Environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs?ref=25.05";
  };

  outputs =
    { flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            cargo
            clang
            clippy
            # openssl.dev
            # pkg-config
            rustc
            rustfmt
            sccache
          ];

          shellHook = ''
            cargo --version
            cargo-clippy --version
            rustc --version
            rustfmt --version
            sccache --version
          '';

          CC = "${pkgs.clang}/bin/clang";
          CXX = "${pkgs.clang}/bin/clang++";

          RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
          RUSTC_WRAPPER = "${pkgs.sccache}/bin/sccache";
        };
      }
    );
}
