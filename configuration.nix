{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [
    "nix-command" "flakes"
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "gabriel" = import ./home.nix;
    };
  };

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  }; 

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  console.keyMap = "br-abnt2";

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.gabriel = {
    isNormalUser = true;
    description = "Gabriel Rodrigues";
    extraGroups = [ "networkmanager" "wheel" ];

    packages = with pkgs; [
      #code editors
      nano gedit neovim vscode vim

      #java things
      jetbrains.idea-community eclipses.eclipse-java 
      jdk8 jdk21 jdk17 

      #terminal stuff
      kitty zsh oh-my-zsh
      neofetch lf ripgrep bat zoxide nyancat
      git docker wget htop 
      unzip
      parted woeusb-ng wlr-randr

      #misc
      syncthing obsidian spotify obs-studio 
      steam gcc nodejs gparted
      onlyoffice-bin inkscape rofi
      insomnia pavucontrol firefox filezilla
      inputs.zen-browser.packages."x86_64-linux".specific

      steam discord vlc deluge blender
	    gnome3.gnome-tweaks
    ];
  };

  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  hardware.opengl = {
    enable = true;
  };
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot.supportedFilesystems = [ "ntfs" ];
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; 
      dedicatedServer.openFirewall = true;
    };

    zsh.enable =  true; 
  };

  nixpkgs.config = {
    permittedInsecurePackages = [
      "electron-25.9.0"
      "electron-19.1.9"
    ]; 
  };

  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;

  system.stateVersion = "24.05"; 
}