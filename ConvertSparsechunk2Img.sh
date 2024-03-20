#!/bin/bash
# Sparsechunk2Img / Moto Header and Footer Remover by FrogMaster- @ xda-developers
# Perform Sparsechunk Conversion 
echo "Calling simg2img to perform sparsechunk conversion to RAW IMG file"
simg2img system.img_sparsechunk.* system.img.raw

# Use DDRescue to remove the Moto header by skipping the first 131072 bytes
echo Removing the Moto Header from the system.img.raw skipping the first 131072 bytes
ddrescue -b 512k -i 131072 -o 0 system.img.raw system.img
echo "Removing Raw Image"
rm -rf system.img.raw
echo "Removing Moto Footer"
# Use DDRescue to remove the Moto header by removing the last 4096 bytes
ddrescue -s "$(($(stat -c "%s" system.img) - 4096))" system.img system_cleaned.img
# Old Method using HEAD
#head -c $(( 4*1024*-1 )) system.img > system_cleaned.img 
echo "Removing Moto Image"
mv -f system_cleaned.img system.img 
echo "Removing sparse chunks"
rm -rf *sparsechunk.*
echo "system.img is ready"
