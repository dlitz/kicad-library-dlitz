#!/bin/bash
set -eu -o pipefail
thisdir="$(dirname "$(readlink -f "$0")")"
identifier_as_dir="$(jq .identifier -r < metadata.json | tr '.' '_')"
KICAD8_3RD_PARTY="${KICAD8_3RD_PARTY:-$HOME/.var/app/org.kicad.KiCad/data/kicad/8.0/3rdparty}"
test -e "${KICAD8_3RD_PARTY}" || { echo "KICAD8_3RD_PARTY directory does not exist: ${KICAD8_3RD_PARTY}"; exit 1; }
for d in 3dmodels footprints resources symbols; do
    if ! test -d "${KICAD8_3RD_PARTY}/$d"; then
        mkdir "${KICAD8_3RD_PARTY}/$d"
    fi
    ln -svfT "$thisdir/$d" "${KICAD8_3RD_PARTY}/$d/$identifier_as_dir"
done
