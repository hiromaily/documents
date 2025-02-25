# ストアドプロシージャ（Stored Procedure）とストアドファンクション（Stored Function）の違いについて

MySQLにもストアドプロシージャ (Stored Procedure) およびストアドファンクション (Stored Function) があり、これらを利用することで、複雑な処理や繰り返し実行する処理をデータベースサーバー上にまとめておくことができ、クライアントから簡単に呼び出すことができる。

- **ストアドプロシージャ**：複数のSQL文を実行する一連の処理を定義。
- **ストアドファンクション**：関数的な処理を行い、結果を返すSQLファンクションを定義。

## ストアドプロシージャ (Stored Procedure)

ストアドプロシージャは、特定の一連のSQL文を実行するためのもので、複数のSQL操作をカプセル化して再利用を容易にします。


### ストアドプロシージャの例

```sql
DELIMITER //

CREATE PROCEDURE GetUserByID(IN userID INT)
BEGIN
    SELECT * FROM Users WHERE id = userID;
END //

DELIMITER ;
```

このプロシージャは、`Users` テーブルから特定の `id` に基づいてユーザー情報を取得するものです。呼び出しは次のように行います：

```sql
CALL GetUserByID(1);
```

## ストアドファンクション (Stored Function)

ストアドファンクションは、値を返すSQLファンクションを定義するもので、関数的な処理を実装する際に使われます。

### ストアドファンクションの例

```sql
DELIMITER //

CREATE FUNCTION GetFullName(userID INT) RETURNS VARCHAR(255)
BEGIN
    DECLARE fullName VARCHAR(255);
    SELECT CONCAT(firstName, ' ', lastName) INTO fullName
    FROM Users WHERE id = userID;
    RETURN fullName;
END //

DELIMITER ;
```

このファンクションは、`Users` テーブルの `id` に基づいてユーザーのフルネームを返します。呼び出しは次のように行います：

```sql
SELECT GetFullName(1);
```
