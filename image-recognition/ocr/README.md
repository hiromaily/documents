# OCR

OCR（`Optical Character Recognition/Reader`、オーシーアール、光学的文字認識）とは、手書きや印刷された文字を、イメージスキャナやデジタルカメラによって読みとり、コンピュータが利用できるデジタルの文字コードに変換する技術

## OCR の処理の流れ

1. 画像取り込み(アップロード)
2. レイアウト解析 (deskew: スキャンした画像の傾きや歪みを修正する)
3. ~~グレースケールにコンバート~~
4. 解析及び抽出
5. 抽出データのバリデーション

## OCR でよく使われるサービス及びライブラリ

| ライブラリ/Service    | 形態       | 説明                                           | 使用例                                           |
| --------------------- | ---------- | ---------------------------------------------- | ------------------------------------------------ |
| tesseract             | OpenSource | OCR engine 機能をもつライブラリ                |                                                  |
| GCP Vision API        | Cloud      | 画像、ドキュメント、動画から分析情報を抽出する | [Link](https://note.com/newbees/n/n39f67f6daff0) |
| AWS Textract          | Cloud      | データを、あらゆるドキュメントから自動的に抽出 |                                                  |
| AWS Rekognition Image | Cloud      | ラベル検出と画像プロパティ                     |                                                  |

## OCR のサービス

- [Llama OCR](https://llamaocr.com/)
  - [npm: llama-ocr](https://github.com/Nutlope/llama-ocr)
  - 日本語もきれいに文字に起こすことができるが、完全ではない
- [MPLUG-DOCOWL2](https://github.com/X-PLUG/mPLUG-DocOwl)
  - [OCR はもう不要？視覚的特徴とテキストを高精度に捉える！次世代マルチモーダル AI モデル『MPLUG-DOCOWL2』](https://qiita.com/ryosuke_ohori/items/34581692852b8b406139)
- [Mistral OCR](https://mistral.ai/news/mistral-ocr)
  - [高速かつ高精度な文字認識AIモデル「Mistral OCR」が登場](https://gigazine.net/news/20250307-mistral-ocr/)
- [国立国会図書館のOCRライブラリが凄くよかった件(Windows向け)](https://qiita.com/yanosen_jp/items/9d3852c29c80dbb952f2)
  - 国立国会図書館が公開しているOCRライブラリ、[NDLOCR](https://lab.ndl.go.jp/news/2023/2023-07-12/)
