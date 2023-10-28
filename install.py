#!/usr/bin/python3

from enum import Enum, IntEnum
import os
from pathlib import Path
import sys


class Platform(Enum):
    Unknown = 0
    Linux = 1
    Windows = 2


class VerboseLevel(IntEnum):
    Error = 0
    Warning = 1
    Info = 2
    Trace = 3


NEOVIM_INSTALL_DIR: dict[Platform, Path] = {
    Platform.Linux: Path(os.environ["HOME"]) / ".config" / "nvim",
    Platform.Windows: Path(os.environ["LOCALAPPDATA"]) / "nvim",
}


class InstallFailedError(Exception):
    def __init__(self, reason):
        self.message = f"Failed installation because: {reason}"


def get_platform() -> Platform:
    p = Platform.Unknown

    if sys.platform == "linux":
        p = Platform.Linux
    elif sys.platform == "win32":
        p = Platform.Windows

    return p


def get_dotfile_root():
    return Path(__file__).parent


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
    src: Path, dest: Path, with_backups: bool, is_dir: bool, verbose=VerboseLevel.Info
):
    if not src.exists():
        raise InstallFailedError(f"{str(src)} does not exists")

    if dest.exists():
        if with_backups:
            backup = get_backup_path(dest)
            dest.rename(backup)
            if verbose >= VerboseLevel.Trace:
                print(f"Backup'ed {str(dest)} -> {str(backup)}")
    src.symlink_to(dest, target_is_directory=is_dir)
    if verbose >= VerboseLevel.Info:
        print(f"Installed {str(src)} -> {str(dest)}")


def install_neovim(with_backups: bool):
    platform = get_platform()
    src: Path | None = None
    dest: Path | None = None
    if src is None or dest is None:
        raise InstallFailedError(
            f"Installation settings could be determine for platform {platform}"
        )
    src = get_dotfile_root() / "neovim"
    dest = NEOVIM_INSTALL_DIR[platform]
    try:
        install(src, dest, with_backups, is_dir=True)
    except Exception as e:
        raise InstallFailedError("Failed installing Neovim") from e


def ask_for_backups() -> bool:
    return True


def main():
    with_backups = ask_for_backups
    pass
    #todo: add install calls


if __name__ == "__main__":
    main()
