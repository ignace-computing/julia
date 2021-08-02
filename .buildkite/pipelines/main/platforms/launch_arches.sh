#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

PLATFORM="$1"

cat "$SCRIPT_DIR/$PLATFORM.arches" | sed 1,1d | tr -s ' ' | while read line; do
  if [[ $line == \#* ]]; then
    continue
  fi
  ARCH=`echo $line | cut -d ' ' -f 1`
  ROOTFS_ARCH=`echo $line | cut -d ' ' -f 2`
  ROOTFS_PACK_TAG=`echo $line | cut -d ' ' -f 3`
  ROOTFS_PACK_TREE=`echo $line | cut -d ' ' -f 4`
  ROOTFS_TEST_TAG=`echo $line | cut -d ' ' -f 5`
  ROOTFS_TEST_TREE=`echo $line | cut -d ' ' -f 6`
  echo "Launching: PLATFORM=$PLATFORM ARCH=$ARCH ROOTFS_ARCH=$ROOTFS_ARCH"
  buildkite-agent pipeline upload "$SCRIPT_DIR/$PLATFORM.yml"
done
