{ config, pkgs, ... }:
let
  unstable = import <unstable> { config.allowUnfree = true; };
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.bat.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "uday";
  home.homeDirectory = "/home/uday";

  home.packages = [
      pkgs.unzip
      pkgs.vlc
      pkgs.handlr
      pkgs.htop
      pkgs.neofetch
      pkgs.flatpak
      pkgs.discord
    ];

    programs.git = {
      enable = true;
      userName = "udaymehta";
      userEmail = "udaymehta.1011@gmail.com";
    };

  home.stateVersion = "22.05";
}
