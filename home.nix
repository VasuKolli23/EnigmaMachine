{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "vkolli";
  home.homeDirectory = "/home/vkolli";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # nix
    nh
    nixd
    nixpkgs-fmt

    # misc cli
    ripgrep
    tree
    fastfetch
    fd
    
    # fonts
    nerd-fonts.roboto-mono
    nerd-fonts.jetbrains-mono

    # editors
    kdePackages.kate
    libreoffice-qt

    # browser
    vivaldi
    vivaldi-ffmpeg-codecs
    
    # multimedia
    ffmpeg
    freetube
    vlc

    # development
    devenv
    kdePackages.yakuake

    # remote desktop
    omnissa-horizon-client
  ];

  programs.home-manager.enable = true;
  programs.bash.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "Vasu Kolli";
      user.email = "vasukolli23@gmail.com";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autoStash = true;
    };
  };

  programs.vscode.enable = true;
  programs.starship.enable = true;
  programs.eza = {
    enable = true;
    icons = "auto";
    enableBashIntegration = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
      "--all"
    ];
  };
  
  programs.nixvim = {
    enable = true;
    colorschemes.onedark.enable = true;
    plugins.lualine.enable = true;
    opts.number = true;
  };
  
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
  
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "dracula";
      theme_background = false;
      shown_boxes = "cpu mem proc";
    };
  };

  # Flatpak support with declarative packages via nix-flatpak.
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [ "com.surfshark.Surfshark" ];
  };
}
