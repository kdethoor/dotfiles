#!/usr/bin/python3

from enum import Enum, IntEnum
import os
from pathlib import Path
import sys
import traceback


class Dotfiles:
    NEOVIM_DIR_NAME = "nvim"
    POWERSHELL_DIR_NAME = "powershell"

    @staticmethod
    def get_root() -> Path:
        return Path(__file__).parent

    @classmethod
    def get_neovim_dir(cls) -> Path:
        return cls.get_root() / cls.NEOVIM_DIR_NAME

    @classmethod
    def get_powershell_dir(cls) -> Path:
        return cls.get_root() / cls.POWERSHELL_DIR_NAME


class Platform(Enum):
    Unknown = 0
    Linux = 1
    Windows = 2


class VerboseLevel(IntEnum):
    Error = 0
    Warning = 1
    Info = 2
    Trace = 3


class InstallFailedError(Exception):
    def __init__(self, reason):
        self.message = f"Failed installation because: {reason}"


class Neovim:
    @staticmethod
    def get_install_dir(platform: Platform) -> Path | None:
        if platform == Platform.Linux:
            return Path(os.environ["HOME"]) / ".config" / "nvim"
        elif platform == Platform.Windows:
            return Path(os.environ["LOCALAPPDATA"]) / "nvim"
        else:
            return None

class PowerShell:
    @staticmethod
    def get_install_dir(platform: Platform) -> Path | None:
        if platform == Platform.Windows:
            return Path(os.environ["HOME"]) / "Documents" / "WindowsPowerShell"
        else:
            return None


def get_platform() -> Platform:
    p = Platform.Unknown

    if sys.platform == "linux":
        p = Platform.Linux
    elif sys.platform == "win32":
        p = Platform.Windows

    return p


def get_backup_path(path) -> Path:
    def _get_backup_path(path: Path, i: int) -> Path:
        return Path(f"{str(path)}_{i}")

    i = 0
    backup = _get_backup_path(path, i)
    while backup.exists():
        i = i + 1
        backup = _get_backup_path(path, i)
    return backup


def install(
    src: Path, dest: Path, with_backups: bool, is_dir: bool, target_name: str, verbose=VerboseLevel.Info
):
    if not src.exists():
        raise InstallFailedError(f"{str(src)} does not exist")

    if dest.exists():
        if with_backups:
            backup = get_backup_path(dest)
            dest.rename(backup)
            if verbose >= VerboseLevel.Trace:
                print(f"Backup'ed {str(dest)} -> {str(backup)}")
        else:
            raise InstallFailedError(
                f"{target_name} config already exists at {str(dest)} but backups are disabled"
            )
    dest.symlink_to(src, target_is_directory=is_dir)
    if verbose >= VerboseLevel.Info:
        print(f"Installed {str(src)} -> {str(dest)}")


def install_neovim(with_backups: bool):
    platform = get_platform()
    src = Dotfiles.get_neovim_dir()
    dest = Neovim.get_install_dir(platform)
    if dest is None:
        raise InstallFailedError(
            f"Neovim installation directory could not be determined for platform {platform}"
        )
    try:
        install(src, dest, with_backups, True, "Neovim")
    except Exception as e:
        raise InstallFailedError("Failed installing Neovim") from e

def install_powershell(with_backups: bool):
    platform = get_platform()
    src = Dotfiles.get_powershell_dir()
    dest = PowerShell.get_install_dir(platform)
    if dest is None:
        raise InstallFailedError(
            f"PowerShell installation directory could not be determined for platform {platform}"
        )
    try:
        install(src, dest, with_backups, True, "PowerShell")
    except Exception as e:
        raise InstallFailedError("Failed installing PowerShell") from e


def ask_for_backups(verbose=VerboseLevel.Info) -> bool:
    with_backups: None | bool = None
    while with_backups is None:
        answer = input("Backup the existing configurations before each install? [Y|n] ")
        if answer in ["Y", "y", ""]:
            with_backups = True
        elif answer in ["N", "n"]:
            with_backups = False
    if verbose >= VerboseLevel.Info:
        print(
            f"Existing configurations will{' ' if with_backups else ' not '}be backup'ed before each install"
        )
    print()
    return with_backups


def main() -> int:
    with_backups = ask_for_backups()
    try:
        install_neovim(with_backups)
        install_powershell(with_backups)
    except Exception:
        traceback.print_exc(file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    res = main()
    sys.exit(res)
