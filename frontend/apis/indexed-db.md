# IndexedDB

- ファイルや blob を含む大量の構造化データをクライアント側で保存するための低レベル API
- この API はインデックスを使用して、高パフォーマンスなデータの検索を行うことができる
- WebStorage は比較的少量のデータを保存するのに有用だが、構造化された非常に多くのデータを扱うには不十分
- Web Worker 内で IndexedDB API は利用可能
- JavaScript ベースのオブジェクト指向データベース
  - Key でインデックス付けされたオブジェクトを保存および取り出すことができる
- IndexedDB を扱う操作は非同期に実行する
- 可能な保存サイズは 50MB
- 注意点として、プライベートブラウジングモードは、大半のデータストレージに対応していない

## References

- [IndexedDB API](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API)
- [IndexedDB key characteristics and basic terminology](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API/Basic_Terminology)
- [CanIUse](https://caniuse.com/?search=indexeddb)
