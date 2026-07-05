#!/bin/bash

# Let the user decide whether to install fish or zsh as their default shell
echo "Choose your default shell:"
select shell in "fish" "zsh"; do
    case $shell in
        fish )
            echo "Installing Fish shell..."
            sudo pacman -S --noconfirm fish
            chsh -s /usr/bin/fish
            log "Installing Fisher and Tide..."
fish <<'EOF'
if not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher install jorgebucaran/fisher
end
if not fisher list | grep -q "IlanCosman/tide"
    fisher install IlanCosman/tide@v6
end
EOF
            break;;
        zsh )
            echo "Installing Zsh shell..."
            sudo pacman -S --noconfirm zsh
            chsh -s /usr/bin/zsh
            cp ./scripts/.zshrc ~/.zshrc
            break;;
        * )
            echo "Invalid option. Please choose 1 or 2."
    esac
done
