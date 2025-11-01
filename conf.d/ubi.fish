function __ubi_download_on_install --on-event ubi_install --description 'Install ubi when plugin is added'
    set -l target_dir (test -n "$XDG_BIN_HOME"; and echo "$XDG_BIN_HOME"; or echo "$HOME/.local/bin")
    set -l target_path $target_dir/ubi

    if test -x $target_path
        return 0
    end

    if not test -d $target_dir
        command mkdir -p $target_dir
    end

    TARGET=$target_dir sh (curl -fsSL "https://raw.githubusercontent.com/houseabsolute/ubi/master/bootstrap/bootstrap-ubi.sh" | psub)

    if not test -x $target_path
        echo "ubi-fish: ubi executable not found at $target_path after install" >&2
        return 1
    end

    return 0
end

abbr -a -- ubi ubi -i (test -n "$XDG_BIN_HOME"; and echo "$XDG_BIN_HOME"; or echo "$HOME/.local/bin")
