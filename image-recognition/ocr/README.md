# OCR

OCR（`Optical Character Recognition/Reader`、オーシーアール、光学的文字認識）とは、手書きや印刷された文字を、イメージスキャナやデジタルカメラによって読みとり、コンピュータが利用できるデジタルの文字コードに変換する技術

## OCRの処理の流れ

1. 画像取り込み(アップロード)
2. レイアウト解析 (deskew: スキャンした画像の傾きや歪みを修正する)
3. ~~グレースケールにコンバート~~
4. 解析及び抽出
5. 抽出データのバリデーション

## OCRでよく使われるサービス及びライブラリ

| ライブラリ/Service    | 形態       | 説明                                           | 使用例                                           |
| --------------------- | ---------- | ---------------------------------------------- | ------------------------------------------------ |
| tesseract             | OpenSource | OCR engine機能をもつライブラリ                 |                                                  |
| GCP Vision API        | Cloud      | 画像、ドキュメント、動画から分析情報を抽出する | [Link](https://note.com/newbees/n/n39f67f6daff0) |
| AWS Textract          | Cloud      | データを、あらゆるドキュメントから自動的に抽出 |                                                  |
| AWS Rekognition Image | Cloud      | ラベル検出と画像プロパティ                     |                                                  |

## OCRのサービス

- [Llama OCR](https://llamaocr.com/)
  - [npm: llama-ocr](https://github.com/Nutlope/llama-ocr)
  - 日本語もきれいに文字に起こすことができるが、完全ではない
