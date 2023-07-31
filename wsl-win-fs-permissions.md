# POSIX Permissions of Windows Files in WSL

## Enabling POSIX Permissions for Windows Files in WSL

Add the following configuration in `/etc/wsl.conf`:

```.conf
[automount]
options  = "metadata,umask=22,fmask=11"
```

**Remember to restart WSL to make the change effective.**

The above configuration enables the `metadata` feature of _DrvFs_ when mounting the Windows filesystem in WSL.
Additional unmasking options are set for unsetting the permissions bits for new files. More info in the 
[official WSL advanced config doc](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#automount-options).

### Caveats

Certain caveats of the `metadata` feature must be kept in mind[^1]:

1. Editing a file using a Windows editor may remove the file’s Linux metadata. In this case, the file will revert to 
   its default permissions.
2. Removing all write bits on a file in WSL will make Windows mark the file as read-only.
3. If you have multiple WSL distros installed or multiple Windows users with WSL installed, they will all use the same 
   metadata on the same files. The uid’s of each WSL user account might differ. This something to consider when setting 
   permissions.

------------------------------------------------------------------------------------------------------------------------

[^1]: https://devblogs.microsoft.com/commandline/chmod-chown-wsl-improvements/#important-caveats
