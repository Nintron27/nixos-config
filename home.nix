{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
  customNodePackages = import ./pkgs/nodePackages/default.nix {};
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nintron";
  home.homeDirectory = "/home/nintron";

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      polybar = pkgs.polybar.override {
        i3Support = true;
        pulseSupport = true;
      };
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable finding installed fonts
  fonts.fontconfig.enable = true;
  
  # Packages to install
  home.packages = with pkgs; [
    # fonts
    fira-code
    fira-code-symbols
    (nerdfonts.override { fonts = [ "FiraCode" ]; })

    # desktop stuff
    i3lock
    playerctl
    feh

    # development
    git
    tmux
    hey
    nodejs
    beekeeper-studio
    zellij
    go
    flyctl
    helix
    go-migrate
    lazygit
    #unstable for newer features faster
    # unstable.postman
    unstable.lf
    unstable.cargo-generate
    unstable.sqlc
    unstable.vscodium

    # un-categorized packages
    htop
    wget
    vlc
    ffmpeg-full
    baobab
    spotify
    pavucontrol
    neofetch
    wcalc
    gnome.gedit
    gnome.gnome-screenshot
    gnome.nautilus
    gnome.file-roller
    gnome.cheese
    gimp
    firefox
    brave
    unstable.discord
    # slack
    jdk17_headless
    minecraft
    prismlauncher
    obsidian
    obs-studio
    filezilla
    gparted

    # langservers / Formatters
    nodePackages.prettier
    nil
    gopls # go
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    customNodePackages.svelte-language-server
    customNodePackages."@tailwindcss/language-server"
    nodePackages.graphql-language-service-cli
    python39Packages.pylsp-mypy
    taplo # toml
    nodePackages.yaml-language-server # yaml
    lldb
  ];

  ###########################
  # Packages and/or Configs #
  ###########################

  # window manager
  xsession = {
    enable = true;
  
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = import ./config/i3/config.nix;
    };
  };

  # polybar
  services.polybar = {
    enable = true;
    script = '''';
  };
  home.file.".config/polybar" = {
    source = ./config/polybar;
  };

  # dunst
  services.dunst = {
    enable = true;
    configFile = ./config/dunst/dunstrc;
  };

  # redshift
  services.redshift = {
    enable = true;
    tray = true;

    dawnTime = "07:30";
    duskTime = "20:45";

    temperature = {
      day = 5500;
      night = 3700;
    };
  };

  # GTK 2/3
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
      package = unstable.catppuccin-gtk.override {
        accents = ["mauve"];
        size = "standard";
        variant = "mocha";
      };
    };
  };

  # Set the cursor theme
  home.file.".icons/default".source = "${pkgs.catppuccin-cursors.mochaLight}/share/icons/Catppuccin-Mocha-Light-Cursors";

  # application launcher
  programs.rofi = import ./config/rofi/config.nix;

  # direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
 
  # fish
  home.file.".config/fish/themes/CatppuccinMocha.theme" = {
    source = ./config/fish/CatppuccinMocha.theme;
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fish_config theme choose CatppuccinMocha
      export EDITOR=hx
      # Set PATH to add .local/bin
      export PATH="$PATH:/home/nintron/.local/bin"
    '';
  };
  
  # starship
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
    };
  };

  # alacritty
  programs.alacritty.enable = true;
  home.file.".config/alacritty/alacritty.yml" = {
    source = ./config/alacritty/alacritty.yml;
  };
  home.file.".config/alacritty/catppuccin-mocha.yml" = {
    source = ./config/alacritty/catppuccin-mocha.yml;
  };

  # helix
  home.file.".config/helix" = {
    source = ./config/helix;
  };

  # tmux
  home.file.".config/tmux/tmux.conf" = {
    source = ./config/tmux/tmux.conf;
  };

  # zellij
  home.file.".config/zellij/config.kdl" = {
    source = ./config/zellij/config.kdl;
  };

  # lf
  home.file.".config/lf/lfrc" = {
    source = ./config/lf/lfrc;
  };

  # custom scripts
  home.file.".local/bin" = {
    source = ./scripts;
  };
}
