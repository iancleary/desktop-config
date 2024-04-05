# Nextcloud Autosync Service

[Nextcloud Autosync on NixOS Wiki](https://nixos.wiki/wiki/Nextcloud#Nextcloudcmd)

> The argument -h will enable syncing hidden files. For demonstration purpose username and password are supplied as an argument. This is a security risk and shouldn't be used in production.
>
> Using Home Manager we can create a systemd-timer which automatically runs the sync command every hour for the user myuser.

```
home-manager.users.myuser = {
  home.file.".netrc".text = ''default
    login example
    password test123
  '';
};
```

> The `-n` option below requires the above file to exist.  **DON'T STORE YOUR SECRET UNENCRYPTED IN THE NIX STORE**

```text
default
login exampleusername
password examplepassword
```

## Nextcloudcmd help

```bash
❯ nextcloudcmd --help                                                                             ─╯
nextcloudcmd - command line Nextcloud client tool

Usage: nextcloudcmd [OPTION] <source_dir> <server_url>

A proxy can either be set manually using --httpproxy.
Otherwise, the setting from a configured sync client will be used.

Options:
  --silent, -s           Don't be so verbose
  --httpproxy [proxy]    Specify a http proxy to use.
                         Proxy is http://server:port
  --trust                Trust the SSL certification.
  --exclude [file]       Exclude list file
  --unsyncedfolders [file]    File containing the list of unsynced remote folders (selective sync)
  --user, -u [name]      Use [name] as the login name
  --password, -p [pass]  Use [pass] as password
  -n                     Use netrc (5) for login
  --non-interactive      Do not block execution with interaction
  --max-sync-retries [n] Retries maximum n times (default to 3)
  --uplimit [n]          Limit the upload speed of files to n KB/s
  --downlimit [n]        Limit the download speed of files to n KB/s
  -h                     Sync hidden files, do not ignore them
  --version, -v          Display version and exit
  --logdebug             More verbose logging
  --path                 Path to a folder on a remote server
```
