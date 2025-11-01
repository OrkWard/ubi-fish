function __fish_ubi_list_forge_types
    printf '%s\n' forgejo github gitlab
end

function __fish_ubi_none_of
    for flag in $argv
        __fish_contains_opt $flag; and return 1
    end
    return 0
end

function __fish_ubi_has_opt
    for flag in $argv
        __fish_contains_opt $flag; and return 0
    end
    return 1
end

function __fish_ubi_allow_project
    __fish_ubi_none_of url self-upgrade
end

function __fish_ubi_allow_tag
    __fish_ubi_none_of url self-upgrade; and __fish_ubi_has_opt project
end

function __fish_ubi_allow_url
    __fish_ubi_none_of project tag self-upgrade
end

function __fish_ubi_allow_self_upgrade
    __fish_ubi_none_of project url
end

function __fish_ubi_exclusive --argument-names primary other_a other_b
    __fish_ubi_none_of $other_a $other_b
end

complete -c ubi -l project -s p -d 'Project to install' -r -n '__fish_ubi_allow_project'
complete -c ubi -l tag -s t -d 'Tag to download (requires --project)' -r -n '__fish_ubi_allow_tag'
complete -c ubi -l url -s u -d 'Direct download URL (exclusive with project/tag)' -r -n '__fish_ubi_allow_url'
complete -c ubi -l in -s i -d 'Install directory (default ./bin)' -r
complete -c ubi -l exe -s e -d 'Executable name inside archive' -r -n '__fish_ubi_exclusive exe extract-all rename-exe'
complete -c ubi -l rename-exe -d 'Rename extracted executable' -r -n '__fish_ubi_exclusive rename-exe extract-all exe'
complete -c ubi -l extract-all -d 'Extract entire archive' -f -n '__fish_ubi_exclusive extract-all exe rename-exe'
complete -c ubi -l matching -s m -d 'Match release filename by substring' -r
complete -c ubi -l matching-regex -s r -d 'Match release filename via regex' -r
complete -c ubi -l forge -d 'Override detected forge' -a '(__fish_ubi_list_forge_types)'
complete -c ubi -l api-base-url -d 'Custom forge API base URL' -r
complete -c ubi -l self-upgrade -d 'Upgrade ubi itself' -f -n '__fish_ubi_allow_self_upgrade'
complete -c ubi -l verbose -s v -d 'Enable verbose logging' -f -n '__fish_ubi_none_of debug quiet'
complete -c ubi -l debug -s d -d 'Enable debug logging' -f -n '__fish_ubi_none_of verbose quiet'
complete -c ubi -l quiet -s q -d 'Suppress most output' -f -n '__fish_ubi_none_of verbose debug'
complete -c ubi -l help -d 'Show help' -f
complete -c ubi -l version -d 'Show version' -f
