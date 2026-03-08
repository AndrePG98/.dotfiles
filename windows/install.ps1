$dotfiles = $PSScriptRoot

# AHK Setup
# $ahkExe = Get-ChildItem "C:\Program Files\Dev\AutoHotKey\v2" -Filter "*.exe" |
#           Select-Object -First 1 -ExpandProperty Name
# [System.Environment]::SetEnvironmentVariable("KOMOREBI_AHK_EXE", $ahkExe, "User")


[System.Environment]::SetEnvironmentVariable("KOMOREBI_CONFIG_HOME", "$dotfiles", "User")
[System.Environment]::SetEnvironmentVariable("WHKD_CONFIG_HOME", "$dotfiles", "User")

# Symlink setup alternative
# # komorebi
# New-Item -ItemType SymbolicLink -Force `
#   -Path "$env:USERPROFILE\komorebi.json" `
#   -Target "$dotfiles\komorebi.json"
#
#
# New-Item -ItemType SymbolicLink -Force `
#   -Path "$env:USERPROFILE\komorebi.bar.json" `
#   -Target "$dotfiles\komorebi.bar.json"
#
#
# New-Item -ItemType SymbolicLink -Force `
#   -Path "$env:USERPROFILE\applications.json" `
#   -Target "$dotfiles\applications.json"
#
# # whkd
# New-Item -ItemType SymbolicLink -Force `
#   -Path "$env:USERPROFILE\.config\whkdrc" `
#   -Target "$dotfiles\whkdrc"



