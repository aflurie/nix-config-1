{ config, pkgs, ... }:
let
  fzfCtrlOpts = pkgs.lib.concatStringsSep " " [
    "$FZF_COMMON_OPTS"
    "--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
    "--preview-window right:50%:hidden:wrap --bind '?:toggle-preview'"
  ];

  fzfCtrlROpts = pkgs.lib.concatStringsSep " " [
    fzfCtrlOpts
    "--history-size=10000"
  ];

  fzfDefaultOpts = pkgs.lib.concatStringsSep " " [
    "--ansi"
    "--color dark,hl:33,hl+:37,fg+:235,bg+:234,fg+:254"
    "--color info:254,prompt:37,spinner:108,pointer:235,marker:235"
    "--reverse"
  ];

  manPath = pkgs.lib.concatStringsSep ":" [
    "/home/ptsirakidis/.nix-profile/share/man"
    "/home/ptsirakidis/.nix-profile/man"
    "${config.system.path}/share/man"
    "${config.system.path}/man"
    "/usr/local/share/man"
    "/usr/share/man"
  ];

  path = pkgs.lib.concatStringsSep ":" [
    "$HOME/.local/bin"
    "$HOME/.cabal/bin"
    "$HOME/.cargo/bin"
    "$HOME/.composer/vendor/bin"
    "$HOME/.node/bin"
    "$HOME/projects/golang/bin"
    "$PATH"
  ];
in
{
  environment = {
    etc."containers/registries.conf".text = import ./etc/containers/registries.nix {};
    etc."containers/policy.json".text     = import ./etc/containers/policy.nix {};

    #
    # Common config files
    #
    etc."dot-files/aspell.conf".text            = import ../common/dot-files/aspell.nix {};
    etc."dot-files/curlrc".text                 = import ../common/dot-files/curlrc.nix {};
    etc."dot-files/ctags".text                  = import ../common/dot-files/ctags.nix {};
    etc."dot-files/htoprc".text                 = import ../common/dot-files/htoprc.nix {};
    etc."dot-files/git/ignore".text             = import ../common/dot-files/git/ignore.nix {};
    etc."dot-files/nixpkgs/config.nix".text     = import ../common/dot-files/nixpkgs/config.nix {};
    etc."dot-files/npmrc".text                  = import ../common/dot-files/npmrc.nix {};

    #
    # Per machine config files
    #
    etc."dot-files/alphaomega/alacritty/alacritty.yml".text = import ./dot-files/alacritty/alacritty.nix {};
    etc."dot-files/alphaomega/fonts.conf".text              = import ./dot-files/fonts.nix {};
    etc."dot-files/alphaomega/gtk-3.0/settings.ini".text    = import ./dot-files/gtk-3.0/settings.nix {};
    etc."dot-files/alphaomega/grobi.conf".text              = import ./dot-files/grobi.nix {};
    etc."dot-files/alphaomega/i3/config".text               = import ./dot-files/i3/config.nix { inherit (pkgs) light pamixer; };
    etc."dot-files/alphaomega/i3/status.toml".text          = import ./dot-files/i3/status.nix {};
    etc."dot-files/alphaomega/rofi/config".text             = import ./dot-files/rofi/config.nix {};
    etc."dot-files/alphaomega/tmux/plugins/kube.tmux".text  = pkgs.lib.fileContents ./dot-files/tmux/plugins/kube.tmux;
    etc."dot-files/alphaomega/tmux.conf".text               = import ./dot-files/tmux.nix { inherit(pkgs) bash; };
    etc."dot-files/alphaomega/Xresources".text              = import ./dot-files/Xresources.nix {};

    #
    # Per-user secret config files
    #
    etc."dot-files/ptsirakidis/gitconfig".text                   = import ../../machine/per-user/gitconfig.nix {};
    etc."dot-files/ptsirakidis/gnus.el".text                     = import ../../machine/per-user/gnus.nix {};
    etc."dot-files/ptsirakidis/offlineimap/config".text          = import ../../machine/per-user/offlineimap/config.nix { inherit (pkgs) cacert; };
    etc."dot-files/ptsirakidis/offlineimap/ca.crt".text          = import ../../machine/per-user/offlineimap/ca.nix {};
    etc."dot-files/ptsirakidis/offlineimap/offlineimap.py".text  = import ../../machine/per-user/offlineimap/offlineimap.nix { inherit (pkgs) gnupg python; };
    etc."dot-files/ptsirakidis/sbt/repositories".text          = import ../../machine/per-user/sbt/repositories.nix {};
    etc."dot-files/ptsirakidis/sbt/1.0/global.sbt".text          = import ../../machine/per-user/sbt/1.0/global.nix {};
    etc."dot-files/ptsirakidis/sbt/1.0/plugins/plugins.sbt".text = import ../../machine/per-user/sbt/1.0/plugins/plugins.nix {};
    etc."dot-files/ptsirakidis/sbt/1.0/sonatype.sbt".text        = import ../../machine/per-user/sbt/1.0/sonatype.nix {};
    etc."dot-files/ptsirakidis/signature".text                   = import ../../machine/per-user/signature.nix {};
    etc."dot-files/ptsirakidis/ssh-config".text                  = import ../../machine/per-user/ssh-user-config.nix {};
    etc."dot-files/ptsirakidis/zshrc".text                       = import ../../machine/per-user/zshrc.nix {};

    extraOutputsToInstall = [ "doc" "lib" "man" "info" ];

    pathsToLink = [ "/lib" "/libexec" "/share" ];

    loginShellInit = ''
      export TERM="screen-256color"
      export LC_ALL="en_US.UTF-8"
      export PAGER="less -R"
      export EDITOR="emacsclient"
      export ALTERNATE_EDITOR="vim"
      export MANPATH="${manPath}"
      export ACLOCAL_PATH="$HOME/.nix-profile/share/aclocal"
      export GOPATH="$HOME/projects/golang"
      export GOPROXY="https://proxy.golang.org"
      export PKG_CONFIG_PATH="$HOME/.nix-profile/lib/pkgconfig"
      export PYTHONPATH="$HOME/.local/lib/python3.6/site-packages:${pkgs.pythonToolsEnv}/lib/python3.6/site-packages"
      export ZSH_CUSTOM="$HOME/.zsh/custom"
      export ZSH_CACHE_DIR="$HOME/.zsh/cache"
      export FZF_BASE="${pkgs.fzf}"
      export FZF_DEFAULT_COMMAND="${pkgs.fd}/bin/fd --type file --color=always --follow --hidden --exclude .git"
      export FZF_COMMON_OPTS="--select-1 --exit-0"
      export FZF_CTRL_T_OPTS="${fzfCtrlOpts}"
      export FZF_CTRL_R_OPTS="${fzfCtrlROpts}"
      export FZF_DEFAULT_OPTS="${fzfDefaultOpts}"
      export PATH="${path}"
    '';

    shells = with pkgs; [
      bashInteractive
      zsh
    ];

    shellAliases = {
      emacs-nox            = "emacs -nw";
      ec                   = "emacsclient -t";
      ll                   = "exa -la";
      lt                   = "exa -T";
      nix-build-out        = "nixBuildOut";
      nix-build-binding-as = "nixBuildBindingAs";
      nix-build-deps       = "nixBuildDeps";
      nix-runtime-deps     = "nixRuntimeDeps";
      nix-check-updates    = "nixCheckUpdates";
      nix-env-rebuild      = "nixEnvRebuild";
    };
  };
}
