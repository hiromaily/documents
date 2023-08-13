# Typechain

[github](https://github.com/dethcrypto/TypeChain)

## Install
```
npm install --save-dev typechain
```

## Generate
```
#e.g.
#typechain --target=(ethers-v5|ethers-v6|truffle-v4|truffle-v5|web3-v1|path-to-custom-target) [glob]

OUT_DIR=ts-out
npx typechain --show-stack-traces --target=ethers-v5 --out-dir ${OUT_DIR} "abis/FooBar.abi"
```

## ABI生成から、tsファイル生成まで
- abi生成
```sh
#!/bin/bash

FILE_PATH=
OUT_EXT=abi

if [ -n "$1" ]; then
    FILE_PATH=$1
fi

# Source directory containing Solidity files
SOURCE_DIR="src${FILE_PATH}"

# Destination directory for ABI files
ABI_DIR="abis${FILE_PATH}"
mkdir -p $ABI_DIR

# Loop through Solidity files in the source directory
for file in ${SOURCE_DIR}/*.sol; do
    # Get the file name without extension
    filename=$(basename -- "$file")
    filename_without_extension="${filename%.*}"
    
    # Generate ABI using forge inspect command
    forge inspect "${file}:${filename_without_extension}" abi > "${ABI_DIR}/${filename_without_extension}.${OUT_EXT}"
    if [ $? -eq 0 ]; then
      echo "Generated ABI for ${file} [Output] ${ABI_DIR}/${filename_without_extension}.ts"
    else
      echo "Failed to generate abi file for ${file}"
    fi
done

echo "ABI generation completed."
```

- ts生成
```sh
#!/bin/bash

FILE_PATH=
IN_EXT=abi

if [ -n "$1" ]; then
    FILE_PATH=$1
fi

# Source directory containing Solidity files
SOURCE_DIR="./abis${FILE_PATH}"

# Destination directory for ABI files
OUT_DIR="out-ts${FILE_PATH}"
mkdir -p $OUT_DIR

# Loop through Solidity files in the source directory
for file in ${SOURCE_DIR}/*.${IN_EXT}; do
    # Get the file name without extension
    filename=$(basename -- "$file")
    filename_without_extension="${filename%.*}"
    
    # Generate ABI using forge inspect command
    #echo target file: "${SOURCE_DIR}/${filename_without_extension}.${EXT}"
    npx typechain --show-stack-traces --target=ethers-v5 --out-dir ${OUT_DIR} "${SOURCE_DIR}/${filename_without_extension}.${IN_EXT}"
    if [ $? -eq 0 ]; then
      echo "Generated ts file for ${file} [Output] ${OUT_DIR}/${filename_without_extension}.ts"
    else
      echo "Failed to generate ts file for ${file}"
    fi
done

echo "TS File generation completed."
```

## Viemと一緒に使うためには？
[Typechain issue: Feature request: add support for viem](https://github.com/dethcrypto/TypeChain/issues/844)

```
With viem, there is no longer a need for TypeChain. Smart contract interactions are typed using abi-type. Users simply need to store ABI in TypeScript files and declared as const.
```

[wagmi: abitype](./wagmi-abitype.md)