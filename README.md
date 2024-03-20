# ConvertSparsechunk2Img.sh
- This script is designed to assist in converting Android system.img files from sparsechunk format to raw format, removing certain headers and footers specific to Moto devices in the process.
- CleanMotoImg will simply remove the Motorola headers from a system.img.raw file, if you have already performed sparsechunk conversion

## Prerequisites
- [simg2img](https://source.android.com/setup/build/building#obtaining-simg2img) - A tool to convert sparse images to raw images.
- [ddrescue](https://www.gnu.org/software/ddrescue/) - A data recovery tool which can copy data from one file or block device to another.
- Bash Shell

## Usage
1. **Clone the Repository:** Clone this repository to your local machine or download the script file directly.
    ```bash
    git clone https://github.com/example/repository.git
    ```

2. **Navigate to the Directory:** Change your current directory to where the script is located.
    ```bash
    cd path/to/script/directory
    ```

3. **Provide Necessary Permissions:** If required, provide execution permission to the script.
    ```bash
    chmod +x convert_system_image.sh
    ```

4. **Execute the Script:** Run the script with the following command:
    ```bash
    ./convert_system_image.sh
    ```

## Functionality
The script performs the following operations:
1. **Sparsechunk Conversion:**
    - Utilizes `simg2img` to convert the Android system image from sparsechunk format (`system.img_sparsechunk.*`) to raw image format (`system.img.raw`).
2. **Remove Moto Header:**
    - Utilizes `ddrescue` to remove the Moto header from the raw image by skipping the first 131072 bytes.
3. **Remove Moto Footer:**
    - Utilizes `ddrescue` to remove the Moto footer from the modified system image by removing the last 4096 bytes.
4. **Clean Up:**
    - Removes intermediate raw image (`system.img.raw`), sparsechunks (`*sparsechunk.*`), and renames the final cleaned system image to `system.img`.

## Notes
- This script assumes the presence of `simg2img` and `ddrescue` in your system's PATH.
- Ensure you have sufficient permissions to execute the script and write to the directories where the script operates.
- Always make sure to have backups of your sparsechunks before performing any modifications, they will get deleted once the process completes.
- You obviously need to have sparsechunk files to convert into .img format. 
- The resulting img file should be readable VIA 7-zip
