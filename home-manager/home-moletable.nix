{ config, pkgs, ... }:

let
  csp = pkgs.writeScriptBin "csp" ''
    #!${pkgs.stdenv.shell}
    wine "/home/mole/.wine/drive_c/Program Files/CELSYS/CLIP STUDIO 1.5/CLIP STUDIO PAINT/CLIPStudioPaint.exe"
  '';
  cam = pkgs.writeScriptBin "cam" ''
    #! /usr/bin/env nix-shell
    #! nix-shell -p ffmpeg -i bash
    if [[ -z $1 ]]; then
      echo "Usage: cam [IPCamera address]"
      false
    else
      ffmpeg -f mjpeg -i "http://$1/live" -pix_fmt yuv420p -f v4l2 /dev/video0
    fi
  '';
  backup = pkgs.writeScriptBin "backup" ''
    #! /usr/bin/env nix-shell
    #! nix-shell -p borgbackup -i bash

    if [[ -z $BORG_REPO || -z $BORG_PASSPHRASE ]]; then
      echo "Please set BORG_REPO and BORG_PASSPHRASE"
      exit 1
    fi

    # some helpers and error handling:
    echo() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
    trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

    echo "Starting backup"

    borg create                         \
        --verbose                       \
        --filter AME                    \
        --list                          \
        --stats                         \
        --show-rc                       \
        --compression lz4               \
        --exclude-caches                \
                                        \
        ::'{hostname}-{now}'            \
        /data/videos                    \
        /data/pictures                  \
        /data/books                     \
        /data/games/Livesplit_1.4.5     \
        /data/music                     \
        /data/documents                 \
        /data/steam-windows/steamapps/common/Beat\ Saber/UserData \
        /data/steam-windows/steamapps/common/Beat\ Saber/Beat\ Saber_Data/CustomLevels \
        /home/mole/CELSYS               \
        /home/mole/stuff                \
        /home/mole/.config/krita*       \

    backup_exit=$?

    echo "Pruning repository"

    borg prune                          \
        --list                          \
        --prefix '{hostname}-'          \
        --show-rc                       \
        --keep-daily    3               \
        --keep-weekly   2               \
        --keep-monthly  3               \

    prune_exit=$?

    # use highest exit code as global exit code
    global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

    if [ $global_exit -eq 0 ]; then
        echo "Backup and Prune finished successfully"
    elif [ $global_exit -eq 1 ]; then
        echo "Backup and/or Prune finished with warnings"
    else
        echo "Backup and/or Prune finished with errors"
    fi

    exit $global_exit
  '';
in
{ imports = [ ./common.nix ];
  nixpkgs.config.allowUnfree = true;
  programs = {
    obs-studio = {
      enable = true;
      # obs-linuxbrowser isn't in nixpkgs on 21.05.
      # I don't need it atm since I stream from windows, so leaving it off
      # plugins = [ pkgs.obs-linuxbrowser ];
    };
  };
  home.packages = [
    csp
    cam
    backup

    pkgs.krita

    # (pkgs.discord.override { nss = pkgs.nss_latest; })
    pkgs.discord
    pkgs.tdesktop # telegram
    pkgs.spotify

    # pkgs.steam
    # pkgs.wineWowPackages.stable
    pkgs.dolphinEmuMaster

    pkgs.ardour # DAW
    pkgs.guitarix # guitar amp sim
    pkgs.drumgizmo # drum machine
    pkgs.helm # synth
    pkgs.zynaddsubfx # synth
    pkgs.geonkick # chiptune percussion

    pkgs.lm_sensors
  ];
}
