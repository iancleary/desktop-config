{ config, pkgs, lib, ... }:

{
  home-manager.users.icleary = {
    home.stateVersion = "22.11";

    home.packages = with pkgs; [
        colorls
        nix-zsh-completions
    ];

    home.file.".p10k.zsh".source = ./dotfiles/.p10k.zsh;

    programs.zsh = {
        enable = true;
        shellAliases = {
            l = "ls -alh";
            ll = "ls -l";
            ls = "colorls";
        };
        # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        enableCompletion = true;

        # https://nixos.org/manual/nix/stable/language/values.html#type-string
        # https://discourse.nixos.org/t/need-help-understanding-how-to-escape-special-characters-in-the-list-of-str-type/11389/4


        ####
        # On each machine, run p10k configure once.  That should create ~/.p10k.zsh with my preferences.
        ####

        # beginning of file
        initExtraFirst = (builtins.readFile /etc/nixos/modules/common/p10k-config/instant_prompt.zsh);

        # end of file
        initExtra = "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh";

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
  };
}
