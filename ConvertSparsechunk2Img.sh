#!/bin/bash

# Error handling
set -e

# Iterate through all folders in the current directory
for folder in */; do
    echo "Processing folder: $folder"
    
    # Check if sparsechunk files exist
    if ls "$folder"/*sparsechunk.* 1> /dev/null 2>&1; then
        echo "Sparsechunk files found in $folder"
        
        # Perform Sparsechunk Conversion
        echo "Calling simg2img to perform sparsechunk conversion to RAW IMG file"
        simg2img "$folder"system.img_sparsechunk.* "$folder"system.img.raw
        
        # Determine the starting offset
        startoffset=$(LANG=C grep -aobP -m1 '\x53\xEF' "$folder"system.img.raw | head -1 | gawk '{print $1 - 1080}')
        
        # Only remove Header/Footer if determined to be Moto image
        if [ "$startoffset" -eq 131072 ]; then
            # Use ddrescue to remove the Moto header by skipping the first 131072 bytes
            echo "Removing the Moto Header from the system.img.raw skipping the first 131072 bytes"
            ddrescue -b 512k -i 131072 -o 0 "$folder"system.img.raw "$folder"system.img.tmp
			      # Remove the RAW Image
            rm -f "$folder"system.img.raw
            # Remove Moto Footer
            echo "Removing Moto Footer"
            ddrescue -s "$(($(stat -c "%s" "$folder"system.img.tmp) - 4096))" "$folder"system.img.tmp "$folder"system.img
            
            # Remove temporary files
            rm -f "$folder"system.img.tmp
        else
            echo "Starting byte is 0, no Moto Header/Footer removal needed."
            mv "$folder"system.img.raw "$folder"system.img
        fi
        
        # Remove sparse chunks
        echo "Removing sparse chunks"
        rm -f "$folder"*sparsechunk.*
        
        echo "system.img is ready in $folder"
    else
        echo "No sparsechunk files found in $folder"
    fi
done
