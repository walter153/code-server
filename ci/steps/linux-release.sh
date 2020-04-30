#!/usr/bin/env bash
set -euo pipefail

main() {
  cd "$(dirname "$0")/../.."

  ./ci/container/exec.sh ./ci/steps/static-release.sh
  ./ci/container/exec.sh yarn pkg
  ./ci/release-container/push.sh
}

main "$@"
