#!/usr/bin/env bash

set -Eeuo pipefail

MAJOR=1
VERSION=$MAJOR.0
INSTALL=$HOME/.local/
APPDIR=v$VERSION
TAR=$APPDIR.tar.gz
BUCKET=https://pgpzinkbtzqilufilgpr.supabase.co/storage/v1/object/public/piccodescript-releases/lts
URL=$BUCKET/v$MAJOR/$TAR

log() {
  printf "[INFO] %s\n" "$1"
}

splash() {
  log "                        "
  log "▄▖▘       ▌  ▄▖    ▘  ▗ "
  log "▙▌▌▛▘▛▘▛▌▛▌█▌▚ ▛▘▛▘▌▛▌▜▘"
  log "▌ ▌▙▖▙▖▙▌▙▌▙▖▄▌▙▖▌ ▌▙▌▐▖"
  log "                    ▌   "
  log "                        "
  log "          $VERSION      "
  log "                        "
  log "         =====          "
  log "   INSTALLATION SCRIPT  "
  log "         =====          "
  log "                        "
  log "   (c) Hexaredecimal    "
  log "                        "
}


downloadTarAndExtract() {
  wget $URL
  tar xvf $TAR
} 

copyToDest() {
  log "copying $1 to $2"
  cp -r $1 $2
}

rootCopyToDest() {
  log "root copying $1 to $2"
  sudo cp -r $1 $2
}

install() {
  log "Installation stated"
  rootCopyToDest $APPDIR/bin $INSTALL
  rootCopyToDest $APPDIR/lib $INSTALL
  log "Installation is done"
}


finalMessage() {
  log ""
  log "Please make sure to add $INSTALL/bin to your PATH"
  log "Try running picoc --version to test the installation"
  log "Run picoc --h for help and picoc run --repl for a quick repl session"
  log ""
  log "Thank you for installing PiccodeScript."
}

handle_error() {
  log "Something went wrong"
  finalCleanUp
}

trap handle_error ERR

main() {
  splash
  downloadTarAndExtract
  install
  finalMessage
}

main
