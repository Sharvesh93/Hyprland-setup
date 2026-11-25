


function fish_prompt
    set_color red
    echo -n '┌──('

    set_color cyan
    echo -n '開発㉿arch'

    set_color red
    echo -n ')-['

    set_color white
    echo -n (prompt_pwd)

    set_color red
    echo ']'

    set_color red
    echo -n '└─'

    set_color brred
    echo -n '› '

    set_color normal
end
