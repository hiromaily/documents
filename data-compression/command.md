# Command

## [unar](https://theunarchiver.com/command-line)

解凍専用のツール

```sh
# Install
brew install unar

# 展開
unar [options] archive [files ...]
```

## 7z

```sh
# Install
brew install p7zip

# ファイルの圧縮
7z a example.txt.7z example.txt

# ディレクトリの圧縮
7z a archive.7z /path/to/directory/

# パスワード付きで圧縮
7z a archive.7z -pPASSWORD file1.txt file2.txt

# 展開
7z x myarchive.7z

# パスワード付きファイルの展開
7z x mysecurearchive.7z -pMyPassword
```
