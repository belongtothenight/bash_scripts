srcDir="/mnt/d/Computer File/SoftwareProgramFile/raspberrypi_os/2023-05-03-raspios-bullseye-arm64.img.xz"

sudo apt-get install xz-utils iat -y

baseName1=$(basename -- "$srcDir")
echo $baseName1
baseName2="${baseName1%.*}"
echo $baseName2
baseName3="${baseName2%.*}"
echo $baseName3
dirName=$(dirname -- "$srcDir")
echo $dirName

unxz -c $srcDir > $dirName/$baseName2
iat $dirName/$baseName2 $dirName/$baseName3.iso
