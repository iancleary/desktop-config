{ inputs, config, pkgs, lib, home-manager, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.users.iancleary = {
    home.stateVersion = "23.05";

    # https://github.com/nix-community/nix-direnv#via-home-manager
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    home.packages = with pkgs; [
        colorls
        nix-zsh-completions
        yaru-theme
        gnomeExtensions.user-themes
        gnomeExtensions.tray-icons-reloaded
        gnomeExtensions.vitals
        gnomeExtensions.dash-to-panel
        gnomeExtensions.sound-output-device-chooser
        gnomeExtensions.space-bar
    ];

    home.file."dvd".source = ./dotfiles/dvd;
    home.file."dvd".target = ".local/bin/dvd";
    home.file."dvd".executable = true;
    home.file."dvt".source = ./dotfiles/dvt;
    home.file."dvt".target = ".local/bin/dvt";
    home.file."dvt".executable = true;

    home.file.".p10k.zsh".source = ./dotfiles/.p10k.zsh;
    home.file.".p10k.zsh".target = ".p10k.zsh";

    programs.zsh = {
        enable = true;
        shellAliases = {
            l = "ls -alh";
            ll = "ls -l";
            ls = "ls -F";
            ga = "git add";
            gc = "git commit -m";
            gs = "git status";
            gp = "git push origin";
            gl = "git pull origin";
            gcm = "git checkout main && git pull origin main && git branch -D ";
            gd = "git diff";
            gds = "git diff --staged";
            gr = "git reset HEAD --hard";
            hg = "history|grep";  # search bash history, I swapped the letters for github-cli compatibility
            left = "ls -t -1";  # most recently edited files
            cg = "cd `git rev-parse --show-toplevel`";  # go to git main level
        };
        # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        enableCompletion = true;

        # https://nixos.org/manual/nix/stable/language/values.html#type-string
        # https://discourse.nixos.org/t/need-help-understanding-how-to-escape-special-characters-in-the-list-of-str-type/11389/4


        ####
        # On each machine, run p10k configure once.  That should create ~/.p10k.zsh with my preferences.
        ####

        # beginning of file
        # initExtraFirst = (builtins.readFile /etc/nixos/modules/common/p10k-config/instant_prompt.zsh);

        # end of file
        initExtra =
        ''
            [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
            setopt auto_cd
            cdpath=(.. $HOME $HOME/Development $HOME/infra)
        '';

        # https://discourse.nixos.org/t/using-an-external-oh-my-zsh-theme-with-zsh-in-nix/6142/2
        plugins = [
            {
                name = "zsh-autosuggestions";
                src = pkgs.fetchFromGitHub {
                    owner = "zsh-users";
                    repo = "zsh-autosuggestions";
                    rev = "v0.6.4";
                    sha256 = "0h52p2waggzfshvy1wvhj4hf06fmzd44bv6j18k3l9rcx6aixzn6";
                };
            }
            {
                name = "fast-syntax-highlighting";
                src = pkgs.fetchFromGitHub {
                    owner = "zdharma";
                    repo = "fast-syntax-highlighting";
                    rev = "v1.55";
                    sha256 = "0h7f27gz586xxw7cc0wyiv3bx0x3qih2wwh05ad85bh2h834ar8d";
                };
            }
            {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }
        ];
    };

    gtk = {
        enable = true;

        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };

        theme = {
            name = "Yaru-blue-dark";
            package = pkgs.yaru-theme;
        };

        cursorTheme = {
            name = "Numix-Cursor";
            package = pkgs.numix-cursor-theme;
        };

        gtk3.extraConfig = {
            Settings = ''
                gtk-application-prefer-dark-theme=1
            '';
        };

        gtk4.extraConfig = {
            Settings = ''
                gtk-application-prefer-dark-theme=1
            '';
        };
    };

    home.sessionVariables.GTK_THEME = "Yaru-blue-dark";
    # ...

    dconf.settings = {
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
      };
      "org/gnome/desktop/wm/preferences" = {
        workspace-names = [ "Main" ];
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;

        # `gnome-extensions list` for a list
        enabled-extensions = [
            "user-theme@gnome-shell-extensions.gcampax.github.com"
            "trayIconsReloaded@selfmade.pl"
            "Vitals@CoreCoding.com"
            "dash-to-panel@jderose9.github.com"
            # "sound-output-device-chooser@kgshank.net"
            "space-bar@luchrioh"
        ];
      };

      "org/gnome/shell/extensions/user-theme" = {
          name = "Yaru-blue-dark";
      };
    };
  };
}
