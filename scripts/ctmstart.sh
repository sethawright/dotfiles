#!/bin/bash
# Keep CTM launch behavior in the ctm-dev repository.
set -euo pipefail
launcher="${CTM_DEV_DIR:-$HOME/work/ctm-dev}/ctmstart.sh"
if [ ! -x "$launcher" ]; then
  echo "Missing executable $launcher; clone/update ctm-dev first." >&2
  exit 1
fi
exec "$launcher" "$@"
