{ config, pkgs, lib, ... }:
let
  # this will allow the unstable packages to use the same config as on the stable
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in 
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "eric";
  home.homeDirectory = "/home/eric";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
  

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    unstable.vivaldi
    unstable.vivaldi-ffmpeg-codecs
    unstable.gitui
    unstable.vscode.fhs
    unstable.rclone
    unstable.obsidian
    unstable.nextcloud-client
    # unstable.viber
    btop
    dua
    byobu
    tmux
  ];

  programs.fish = {
    enable = true;
    # interactiveShellInit = '''';
    # loginShellInit = '''';
    };

#  home.file.".config/fish/config.fish".text = ''
## fish configuration added by home-manager
#export MAMBA_ROOT_PREFIX=/home/eric/.config/mamba
#if status is-interactive
#  # Commands to run in interactive sessions can go here
#
#  export CONDA_EXE=$MAMBA_ROOT_PREFIX/bin/conda
#  # This uses the type -q command to check if micromamba is in the PATH. If it is, it will run the eval command to set up the micromamba shell hook for fish. The -s fish part tells it to generate code for the fish shell.
#  eval "$(micromamba shell hook -s fish)" 
#  alias ca "python --version" 
#end
#'';

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/eric/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
    WORLD = "hello";
  };

  # configure git with my defaults
  programs.git = {
    enable = true;
    userName = "Eric Yen";
    userEmail = "eric@ericyen.com";
    aliases = {
      prettylog = "...";
    };
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "GitHub";
      };
    };
    extraConfig = {
      core = {
        editor = "nvim";
      };
      color = {
        ui = true;
      };
      push = {
        default = "simple";
      };
      pull = {
        ff = "only";
      };
      init = {
        defaultBranch = "main";
      };
    };
    ignores = [
      ".DS_Store"
      "*.pyc"
      "\..*swp" # swap files
      "*.o"
    ];
  };

  programs.bash = {
    enable = false;
  };
  
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    coc = {
       enable = true;
    };
    extraConfig = ''
      set number relativenumber
      nnoremap <C-t> :NERDTreeToggle<CR>
      nnoremap <C-p> :FZF<CR>
      set shell=/bin/bash
      set mouse=
    '';
    plugins = with pkgs.vimPlugins; [
      vim-surround
      vim-gitgutter
      nerdtree
      fzfWrapper
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
