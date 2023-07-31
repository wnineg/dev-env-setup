# Workaround for the Performance Issue of Windows PATH in WSL

By default, The Windows `PATH` is appended to the WSL one. However, looking up the binaries under the Windows `PATH` can
cause significant performance issue (e.g. `zsh-syntax-highlight`[^1]).

The original Windows `PATH` might be including too many directories. While there are already overhead on accessing
Windows file system from WSL, appending a bunch of directories for lookup just makes it worse.

## Removing the Windows PATH from WSL

The workaround is to disable auto appending Windows `PATH` to WSL by adding the following setting into `/etc/wsl.conf`:

```.conf
[interop]
appendWindowsPath = false
```

**Remember to restart the WSL to make it effective.**

## Adding the Necessary Windows Utilities to WSL PATH

For the necessary Windows utilities we want to access from WSL, we could either:

1. Add the selected directories and files to the WSL `PATH`, e.g. for zsh:

```.zshenv
path+=(
        '/mnt/c/Windows'
        '/mnt/c/Windows/System32'
)
```

2. Make symlinks to the files:

```shell
ln -s /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe ~/.local/bin/powershell.exe
```

------------------------------------------------------------------------------------------------------------------------

[^1]: https://github.com/zsh-users/zsh-syntax-highlighting/issues/790
