# ストアドプロシージャ（Stored Procedure）とストアドファンクション（Stored Function）の違いについて

## ストアドファンクション（Stored Function）

1. **リターン値**:
   - 関数は必ず値を返す。従って、`RETURNS` 句が必要。
   - 関数の返り値の型を定義し、それに従って結果を返す。

2. **呼び出し方法**:
   - 関数は `SELECT` 文や `INSERT`、`UPDATE`、`DELETE` などの中で呼び出すことができる。
   - 例: `SELECT function_name(arguments);`

3. **使用場所**:
   - 関数はクエリの中で利用したり、式中で呼び出して計算を行うのに適している。
   - トランザクション内で呼び出すことができるが、トランザクションを制御（コミットやロールバック）することはできない。

### ストアドファンクションの例

```sql
CREATE OR REPLACE FUNCTION add_numbers(a INT, b INT)
RETURNS INT AS $$
BEGIN
    RETURN a + b;
END;
$$ LANGUAGE plpgsql;

-- 呼び出し
SELECT add_numbers(1, 2);
```

## ストアドプロシージャ（Stored Procedure）

1. **リターン値**:
   - プロシージャは必ずしも値を返さない場合がある。
   - `RETURNS` 句は通常使用されず、返り値がないことがほとんど（ただし、`OUT` パラメータを使って結果を返すことができる）。

2. **呼び出し方法**:
   - プロシージャは `CALL` 文を使って呼び出す。
   - 例: `CALL procedure_name(arguments);`

3. **使用場所**:
   - プロシージャはデータベース操作の自動化や、複数のクエリを一度に実行するシナリオに適している。
   - プロシージャはトランザクション制御を行うことができる。プロシージャ内で `COMMIT` や `ROLLBACK` を実行することができる。

### ストアドプロシージャの例

```sql
CREATE OR REPLACE PROCEDURE transfer_funds(
    account_id_from INT,
    account_id_to INT,
    amount NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- トランザクション制御の例
    START TRANSACTION;
    BEGIN
        UPDATE accounts SET balance = balance - amount WHERE id = account_id_from;
        UPDATE accounts SET balance = balance + amount WHERE id = account_id_to;
        COMMIT;
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
    END;
END;
$$;

-- 呼び出し
CALL transfer_funds(1, 2, 100.0);
```
