# tesseract

Tesseract (テッセラクト)は、オープンソースの光学式文字認識エンジン

## [Command Line Usage](https://tesseract-ocr.github.io/tessdoc/Command-Line-Usage.html)

```sh
# 利用できる言語の確認
tesseract --list-langs

# 解析 & 結果出力
tesseract sample.png output_file --oem 1 -l jpn

```

## help

```
tesseract --help-extra

Usage:
  tesseract --help | --help-extra | --help-psm | --help-oem | --version
  tesseract --list-langs [--tessdata-dir PATH]
  tesseract --print-fonts-table [options...] [configfile...]
  tesseract --print-parameters [options...] [configfile...]
  tesseract imagename|imagelist|stdin outputbase|stdout [options...] [configfile...]

OCR options:
  --tessdata-dir PATH   Specify the location of tessdata path.
  --user-words PATH     Specify the location of user words file.
  --user-patterns PATH  Specify the location of user patterns file.
  --dpi VALUE           Specify DPI for input image.
  --loglevel LEVEL      Specify logging level. LEVEL can be
                        ALL, TRACE, DEBUG, INFO, WARN, ERROR, FATAL or OFF.
  -l LANG[+LANG]        Specify language(s) used for OCR.
  -c VAR=VALUE          Set value for config variables.
                        Multiple -c arguments are allowed.
  --psm NUM             Specify page segmentation mode.
  --oem NUM             Specify OCR Engine mode.
NOTE: These options must occur before any configfile.

Page segmentation modes:
  0    Orientation and script detection (OSD) only.
  1    Automatic page segmentation with OSD.
  2    Automatic page segmentation, but no OSD, or OCR. (not implemented)
  3    Fully automatic page segmentation, but no OSD. (Default)
  4    Assume a single column of text of variable sizes.
  5    Assume a single uniform block of vertically aligned text.
  6    Assume a single uniform block of text.
  7    Treat the image as a single text line.
  8    Treat the image as a single word.
  9    Treat the image as a single word in a circle.
 10    Treat the image as a single character.
 11    Sparse text. Find as much text as possible in no particular order.
 12    Sparse text with OSD.
 13    Raw line. Treat the image as a single text line,
       bypassing hacks that are Tesseract-specific.

OCR Engine modes:
  0    Legacy engine only.
  1    Neural nets LSTM engine only.
  2    Legacy + LSTM engines.
  3    Default, based on what is available.

Single options:
  -h, --help            Show minimal help message.
  --help-extra          Show extra help for advanced users.
  --help-psm            Show page segmentation modes.
  --help-oem            Show OCR Engine modes.
  -v, --version         Show version information.
  --list-langs          List available languages for tesseract engine.
  --print-fonts-table   Print tesseract fonts table.
  --print-parameters    Print tesseract parameters.
```

## [Improving the quality of the output](https://github.com/tesseract-ocr/tessdoc/blob/main/ImproveQuality.md)

- Inverting images: 画像の反転
- Rescaling: 再スケーリング
- Binarisation: 二値化 (分析対象の画像を白と黒の2色のみに変換する画像処理)
- Noise Removal
- Dilation and Erosion: 膨張と侵食
- Rotation / Deskewing: 回転/傾き補正
- Borders
- Transparency / Alpha channel

## どのようにOCRのためにRotateするか？

- [Optimizing Rotation Accuracy for OCR](https://indiantechwarrior.medium.com/optimizing-rotation-accuracy-for-ocr-fbfb785c504b)


### tesseractで、どれだけ回転が必要か調べる

```sh
# 通常の画像
$ tesseract sample.png stdout --psm 0

# 結果
Page number: 0
Orientation in degrees: 0
Rotate: 0
Orientation confidence: 10.54
Script: Han
Script confidence: 0.97

# 90度回転している画像
$ tesseract sample_.png stdout --psm 0
Page number: 0
Orientation in degrees: 270
Rotate: 90
Orientation confidence: 7.74
Script: Han
Script confidence: 1.00
```

このあとは、`OpenCV`などで回転させる

## どのようにOCRのためにDeskewするか？

- [How to automatically deskew (straighten) a text image using OpenCV](https://becominghuman.ai/how-to-automatically-deskew-straighten-a-text-image-using-opencv-a0c30aed83df)

- `OpenCV` で最適化する