# メッセージ認証コード / Message Authentication Code / MAC

- メッセージが`改ざん`されていないか、また誰かが送信者に`なりすまし`していないかどうかをチェックすることができる
- これには、`正真性`と`認証`の二つの性質が必要
  - メッセージの`正真性`とは、`メッセージが書き換えられていない(改ざんされていない)`という性質
  - メッセージの`認証 (authentication)`とは、`メッセージが正しい送信者からのものである`という性質
- つまりメッセージ認証コードとは、正真性を確認しメッセージの認証を行う技術
- `Message Authentication Code` で `MAC` と呼ばれる