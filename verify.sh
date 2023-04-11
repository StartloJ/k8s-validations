#!/bin/ash
kus_path='/src'
overlays=$(ls ${kus_path}/overlays)

for overlay in ${overlays[@]}
do
    MANIFEST_FILE=manifest-$overlay.yaml

    kustomize build overlays/$overlay > ${MANIFEST_FILE}
    [ "$?" -eq "0" ] || { echo "error during kustomize build overlays/$overlay"; exit 1; }

    kubernetes-validate --strict ${MANIFEST_FILE} 2>/dev/null | \
        grep -v ^INFO && { echo "error during kubernetes-validate ${MANIFEST_FILE}"; exit 2; }
    
    echo "kustomize config for overlays/$overlay - ok"
done