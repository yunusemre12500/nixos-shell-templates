{
  description = "Rust Development Environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs?ref=25.05";
  };

  outputs = { flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            cargo
            clang
            clippy
            # openssl.dev
            # pkg-config
            rustc
            rustfmt
          ];

          shellHook = "export PATH=~/.cargo/bin:$PATH";

          CC = "clang";
          CXX = "clang++";

          RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
          RUSTC_WRAPPER = "sccache";
        };
      });
}
