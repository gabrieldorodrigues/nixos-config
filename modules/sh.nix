{ config, pkgs, inputs, ... }:

let
  dotfilesdir = "/home/gabriel/.dotfiles/";
  aliases = {
      ll = "ls -l";
      update = "sudo nixos-generate-config &&
                    sudo rm -rf ${dotfilesdir}hardware-configuration.nix &&
                    sudo cp /etc/nixos/hardware-configuration.nix ${dotfilesdir} &&
                    sudo nixos-rebuild switch --flake ${dotfilesdir}#default";
  };
in 

{
  programs.bash = {
    enable = true;
    shellAliases = aliases; 
  };

  programs.zsh = {
    enable = true;
    shellAliases = aliases;

    oh-my-zsh = {
     enable = true;
     plugins = ["git docker"];
     theme = "edvardm";
    };
  };
}