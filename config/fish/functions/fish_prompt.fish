function fish_prompt
    set -l last_status $status

    # Line 1: Path
    set -l path_color (set_color $matugen_primary 2>/dev/null; or set_color 89b4fa)
    set -l current_dir (string replace -r "^$HOME" '~' $PWD)

    # Line 1: Git branch & dirty status
    set -l git_info ""
    if command -sq git
        set -l branch (command git symbolic-ref --short HEAD 2>/dev/null; or command git rev-parse --short HEAD 2>/dev/null)
        if test -n "$branch"
            set -l git_color (set_color $matugen_secondary 2>/dev/null; or set_color cba6f7)
            set -l dirty ""
            if not command git diff --quiet 2>/dev/null; or not command git diff --cached --quiet 2>/dev/null
                set dirty " *"
            end
            set git_info "  $git_color$branch$dirty"(set_color normal)
        end
    end

    # Print first line
    echo -s $path_color $current_dir (set_color normal) $git_info

    # Line 2: Prompt symbol
    set -l sym_color
    if test $last_status -ne 0
        set sym_color (set_color $matugen_error 2>/dev/null; or set_color f38ba8)
    else
        set sym_color (set_color $matugen_primary 2>/dev/null; or set_color 89b4fa)
    end

    echo -s $sym_color "❯ " (set_color normal)
end
