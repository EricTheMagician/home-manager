{ config, pkgs, lib, ... }:
let
  # this will allow the unstable packages to use the same config as on the stable
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
  autostartPrograms = [ pkgs.slack pkgs.zoom pkgs.vivaldi pkgs.thunderbird ]; 
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
    # unstable.vscode.fhs
    # vscode
    # (
    #   vscode-with-extensions.override 
    #   {
    #     vscodeExtensions = with unstable.vscode-extensions; 
    #     [

    #       # generatl development related packages
    #       ms-vscode-remote.remote-ssh
    #       eamodio.gitlens
    #       # ms-vscode.powershell
    #       # ms-azuretools.vscode-docker


    #       # python related packages
    #       ms-python.python
    #       ms-python.vscode-pylance
          
    #       # C++ related packages
    #       ms-vscode.cpptools
    #       ms-vscode.cmake-tools
    #       xaver.clang-format

    #       # nix related packages
    #       bbenoist.nix
    #       arrterian.nix-env-selector
    #       jnoortheen.nix-ide
    #     ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace 
    #     [
    #       {
    #         publisher = "mjcrouch";
    #         name = "perforce";
    #         version = "4.15.7";
    #         sha256 = "sha256-BXBfxg2GrXvohvu2b02JqtxbGxPxSanNId6DQ39akHI=";
    #       }
    #       {
    #         publisher = "ms-python";
    #         name = "black-formatter";
    #         version ="2023.5.12151008";
    #         sha256 = "sha256-YBcyyE9Z2eL914J8I97WQW8a8A4Ue6C0pCUjWRRPcr8=";
    #       }
    #       {
    #         publisher = "Codeium";
    #         name = "codeium-enterprise-updater";
    #         version = "1.0.9";
    #         sha256 = "sha256-WyDVhc9fjQ+Qgw7F04ESxicRK53vaVxgFtGRHQGpgeI=";
    #       }
    #     ];
    #   }
    # )

    unstable.rclone
    unstable.obsidian
    unstable.nextcloud-client
    # unstable.viber
    btop
    dua
    byobu
    tmux
  ];

  services.syncthing = {
    enable = true;
    tray.enable = false;
  };

  programs.fish = {
    enable = true;
    # interactiveShellInit = '''';
    # loginShellInit = '''';
  };

  programs.direnv = {
    enable = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  programs = {
    gitui.enable = true;
  }


  programs.ssh = {
    enable = true;
    matchBlocks = {
      "headscale" = {
        host = "100.64.0.1";
        user = "root";
      };

      "vscode-server-unraid" = {
        hostname = "100.64.0.11";
        user = "eric";
      };

      "office" = {
        hostname = "192.168.0.37";
        user = "eric";
      };

      "codeium" = {
        hostname = "192.168.0.46";
        user = "codeium";
      };

    "ors-ftp3" = {
        hostname = "192.168.0.25";
        user = "root";
      };

      "vm-server2" = {
        hostname = "131.153.203.129";
        user = "proxmox";
        proxyJump = "192.168.0.37";
      };

      "vm-server2-proxy" = {
        hostname = "10.99.99.4";
        user = "user";
        proxyJump = "vm-server2";
      };

      "vm-server2-internal-infrastructure" = {
        hostname = "10.99.99.5";
        user = "user";
        proxyJump = "vm-server2";
      };

      "vm-server2-mattermost" = {
        hostname = "10.99.99.6";
        user = "user";
        proxyJump = "vm-server2";
      };


      "vm-server2-license-server" = {
        hostname = "10.99.99.7";
        user = "user";
        proxyJump = "vm-server2";
      };
      
      "vm-server2-keycloak" = {
        hostname = "10.99.99.8";
        user = "user";
        proxyJump = "vm-server2";
      };
    };
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
  } //
  builtins.listToAttrs (map
    (pkg:
      {
        name = ".config/autostart/" + pkg.pname + ".desktop";
        value =
          if pkg ? desktopItem then {
            # Application has a desktopItem entry. 
            # Assume that it was made with makeDesktopEntry, which exposes a
            # text attribute with the contents of the .desktop file
            text = pkg.desktopItem.text;
          } else {
            # Application does *not* have a desktopItem entry. Try to find a
            # matching .desktop name in /share/apaplications
            source = (pkg + "/share/applications/" + pkg.pname + ".desktop");
          };
      })
    autostartPrograms);


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
    enable = true;
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
