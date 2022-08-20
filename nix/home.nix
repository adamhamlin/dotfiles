{ config, pkgs, ... }:

{
    # Don't need to update this value unless there's a problem w/ future upgrades
    home.stateVersion = "22.05";

    # Home Manager needs a bit of information about you and the paths it should manage
    home.username = "fallon";
    home.homeDirectory = "/home/fallon";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Add home-manager-help tools
    manual.html.enable = true;
    manual.json.enable = true;

    # Set up some things like XDG_DATA_DIRS (not sure effect on darwin or non-Ubuntu)
    targets.genericLinux.enable = true;

    nixpkgs.config = {
        allowUnfree = true;
        manual.manpages.enable = true;
        # virtualisation.docker.enable = true;
    };

    systemd.user.startServices = true;

    # Packages to install
    home.packages = [
        # Canary
        pkgs.cowsay
        # Languages & Suport
        pkgs.nodejs-16_x
        pkgs.python310
        pkgs.jdk
        pkgs.scala
        pkgs.maven
        pkgs.go
        # Kubernetes
        pkgs.kubectl
        pkgs.kind
        pkgs.skaffold
        pkgs.kubernetes-helm
        pkgs.k9s
        # Tunneling
        pkgs.ngrok
        # Editors
        pkgs.vim
        pkgs.vscode
        # VPN
        pkgs.tailscale
        # Utils
        pkgs.fd
        pkgs.jq
        pkgs.yq
        pkgs.gcc
    ];
}
