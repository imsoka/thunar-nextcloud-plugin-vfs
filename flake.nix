{
  description = "Plugin de Thunar para Nextcloud (thunarx-3 + openvfs)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # Prompt en starship: directorio, rama git, estado, entorno nix y duración
      starshipConfig = pkgs.writeText "starship.toml" ''
        add_newline = true

        format = """
        $directory$git_branch$git_status$nix_shell$cmd_duration
        $character"""

        [character]
        success_symbol = "[❯](bold green)"
        error_symbol = "[❯](bold red)"

        [directory]
        style = "bold cyan"
        truncation_length = 3
        truncate_to_repo = true

        [git_branch]
        symbol = " "
        style = "bold purple"

        [git_status]
        style = "bold yellow"

        [nix_shell]
        symbol = " "
        format = "[$symbol$state]($style) "
        style = "bold blue"

        [cmd_duration]
        min_time = 2000
        format = "took [$duration](bold yellow) "
      '';

      # ZDOTDIR propio: carga tu ~/.zshrc si existe y luego el prompt del proyecto
      zdotdir = pkgs.runCommand "thunar-nextcloud-zdotdir" { } ''
        mkdir -p $out
        cat > $out/.zshrc <<EOF
        [ -f "\$HOME/.zshrc" ] && source "\$HOME/.zshrc"

        export STARSHIP_CONFIG=${starshipConfig}
        eval "\$(${pkgs.starship}/bin/starship init zsh)"
        EOF
      '';
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          # Forja y tickets
          git
          gh
          glab
          jq
          ripgrep
          fd

          # Shell
          zsh
          starship

          # Build del plugin (thunarx-3 en C)
          gcc
          gnumake
          pkg-config
          meson
          ninja
          gtk3
          glib
          thunar
        ];

        shellHook = ''
          # Solo al entrar de forma interactiva; evita bucles y `nix develop -c`
          if [ -t 0 ] && [ -z "$THUNAR_NEXTCLOUD_ZSH" ] && [ -n "$PS1" ]; then
            export THUNAR_NEXTCLOUD_ZSH=1
            export ZDOTDIR=${zdotdir}
            exec ${pkgs.zsh}/bin/zsh
          fi
        '';
      };
    };
}
