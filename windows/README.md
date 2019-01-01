## Setting for windows develop environment

- Procedure
  1. Check `PS C:\> $profile` (It's like `~/.bashrc`)
  1. Check whether the file exists
  1. If not, make one with `New-Item -path $profile -type file -force`
  1. Copy or append `Microsoft.PowerShell_profile.ps1` to the `$profile`
  1. Run `set-executionpolicy remotesigned` in administrator mode Powershell

- Reference: https://superuser.com/a/516704
