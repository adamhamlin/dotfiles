{
    # Inputs == flake dependencies
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    # Outputs == a nix function to create enviorments, nix packages, etc.
    # See https://nixos.wiki/wiki/Flakes#Output_schema for more info
    outputs = { self, nixpkgs, flake-utils, ... }:
        # eachDefaultSystem takes in the function to build the outputs for linux/macos
        flake-utils.lib.eachDefaultSystem (system:
            let pkgs = import nixpkgs { inherit system; };
            in with pkgs; {
                # Default dev shell used by 'nix develop'
                devShell = mkShell {
                    # these packages will be installed for the user
                    buildInputs = [
                        # Languages
                        nodejs-16_x
                        python310
                        # Kubernetes
                        kubectl
                        skaffold
                        kubernetes-helm
                        k9s
                        # Docker
                        docker
                        # Tunneling
                        #ngrok (needs unfree setting)
                        # Utils
                        # vim (?)
                        # hello
                        # sudo
                        fd
                        jq
                        yq
                        gcc
                        # For formatting this file:
                        nixfmt
                    ];
                };
            }
        );
 }