{
  description = "Go Development Environment";

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
            go

            # for gRPC services
            # protobuf
            # protoc-gen-go
            # protoc-gen-go-grpc
          ];

          shellHook = ''
            go version
          '';
        };
      }
    );
}
