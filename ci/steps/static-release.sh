#!/usr/bin/env bash
set -euo pipefail

main() {
  cd "$(dirname "$0")/../.."

  # This, strangely enough, fixes the arm build being terminated for not having
  # output on Travis. It's as if output is buffered and only displayed once a
  # certain amount is collected. Five seconds didn't work but one second seems
  # to generate enough output to make it work.
  local pid
  while true; do
    echo 'Still running...'
    sleep 1
  done &
  pid=$!

  yarn
  yarn vscode
  yarn build
  STATIC=1 yarn release
  ./ci/build/test-static-release.sh
  ./ci/build/archive-static-release.sh

  kill $pid
}

main "$@"
