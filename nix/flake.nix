{
    # See https://nixos.wiki/wiki/Flakes#Flake_schema for more info
    description = "My Flake Configuration";

    # Inputs == flake dependencies
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    # Outputs == a nix function to create enviorments, nix packages, etc.
    outputs = { self, nixpkgs, flake-utils, ... }:
        # eachDefaultSystem takes in the function to build the outputs for linux/macos
        flake-utils.lib.eachDefaultSystem (system:
            let pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
                config.virtualisation.docker.enable = true;
            };
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
                        kind
                        skaffold
                        kubernetes-helm
                        k9s
                        # Docker
                        docker
                        # Tunneling
                        ngrok
                        # Editors
                        vim
                        vscode
                        # VPN
                        tailscale
                        # Utils
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