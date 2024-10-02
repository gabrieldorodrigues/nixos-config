{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./modules/flatpak.nix
    ./modules/sh.nix
  ];

  config = {
    home.username = "gabriel";
    home.homeDirectory = "/home/gabriel";
    home.stateVersion = "24.05"; 

    nixpkgs.config.allowUnfree = true;

    programs = {
      git = {
        enable = true;
        userEmail = "gabriell.dorodrigues@gmail.com";
        userName = "gabrieldorodrigues";
      }; 
    };

    programs.home-manager.enable = true;
  };

}