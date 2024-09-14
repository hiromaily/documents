# Sqlc クエリメタデータ

クエリメタデータとは、SQL `クエリに関する追加情報を注釈として記述すること`で、生成されたコードにその情報を埋め込む機能。このメタデータを活用することで、クエリのドキュメントやコメントを付加し、コードの可読性と理解を向上させることができる。

クエリメタデータを活用することで、プロジェクト全体の品質とメンテナンス性を向上させることができる

1. **ドキュメントの充実**: クエリに関する詳細な説明がコメントとして生成されるため、コードの理解が深まりやすい。
2. **コードの可読性向上**: パラメータや戻り値、注意点に関する情報が明確に記述されているため、他の開発者がコードを読む際に迷うことが少ない。
3. **エラー処理の明確化**: クエリの実行時に想定されるエラーやその対処法についての情報が含まれるため、適切なエラー処理がしやすくなる。

## クエリメタデータの基本

sqlc では、SQL クエリに関する追加情報をコメントとして記述することで、生成された Go コードに埋め込むことができる。これにより、クエリの目的や使用方法を明確に記述することが可能。

## メタデータの書き方

メタデータは、SQL クエリの上部にコメントとして記述する。このコメントは sqlc によって解析され、生成される Go コードに組み込まれる。

### 基本構文

- **`-- name:<クエリ名> :<戻りタイプ>`**: クエリの名前と戻り値のタイプを指定する。
- **`-- @desc:<説明>`**: クエリの説明を記述する。
- **`-- @param <パラメータ名> <説明>`**: クエリのパラメータについて説明する。
- **`-- @return <説明>`**: クエリの戻り値について説明する。

## 具体例

基本的なクエリメタデータの記述例

```sql
-- name: CreateUser :one
-- @desc: 新しいユーザーを作成
-- @param name: ユーザーの名前
-- @param email: ユーザーのメールアドレス
-- @return: 新しく作成されたユーザーの情報
INSERT INTO users (name, email)
VALUES ($1, $2)
RETURNING id, name, email;
```

このコメントにより、クエリの目的やパラメータ、戻り値についての詳細が生成された Go コードに埋め込まれる

```go
// CreateUser inserts a new user into the users table.
// @desc: 新しいユーザーを作成
// @param name: ユーザーの名前
// @param email: ユーザーのメールアドレス
// @return: 新しく作成されたユーザーの情報
func (q *Queries) CreateUser(ctx context.Context, name string, email string) (User, error) {
    row := q.db.QueryRowContext(ctx, createUser, name, email)
    var i User
    err := row.Scan(&i.ID, &i.Name, &i.Email)
    return i, err
}
```

## より詳細なメタデータの記述

さらに詳細なメタデータを記述することも可能。例えば、クエリの実行における注意点や想定されるエラーについてもコメントに含めることができる。

```sql
-- name: GetUserByEmail :one
-- @desc: 指定されたメールアドレスでユーザーを検索
-- @param email: 検索対象のメールアドレス
-- @return: 検索対象のメールアドレスを持つユーザーの情報
-- @error: ユーザーが見つからない場合、no rows in result set エラーが発生
SELECT id, name, email
FROM users
WHERE email = $1;
```

生成される Go コードにこのメタデータがコメントとして含まれるため、クエリの使用方法やエラー処理についての詳細な情報を簡単に確認できる。

```go
// GetUserByEmail fetches a user by their email address.
// @desc: 指定されたメールアドレスでユーザーを検索
// @param email: 検索対象のメールアドレス
// @return: 検索対象のメールアドレスを持つユーザーの情報
// @error: ユーザーが見つからない場合、no rows in result set エラーが発生
func (q *Queries) GetUserByEmail(ctx context.Context, email string) (User, error) {
    row := q.db.QueryRowContext(ctx, getUserByEmail, email)
    var i User
    err := row.Scan(&i.ID, &i.Name, &i.Email)
    return i, err
}
```

## 実際のプロジェクトでの適用例

### SQL ファイルの例

```sql
-- name: UpdateUserEmail :exec
-- @desc: 指定されたユーザーのメールアドレスを更新
-- @param id: 更新対象のユーザーID
-- @param new_email: 新しいメールアドレス
-- @note: メールアドレスは一意である必要がある
UPDATE users
SET email = $2
WHERE id = $1;
```

### 生成される Go コードの例

```go
// UpdateUserEmail updates a user's email address.
// @desc: 指定されたユーザーのメールアドレスを更新
// @param id: 更新対象のユーザーID
// @param new_email: 新しいメールアドレス
// @note: メールアドレスは一意である必要がある
func (q *Queries) UpdateUserEmail(ctx context.Context, id int32, newEmail string) error {
    _, err := q.db.ExecContext(ctx, updateUserEmail, id, newEmail)
    return err
}
```

## クエリメタデータの`name`

いくつかのフォーマットがあり、それに基づいて生成されるGoコードの関数名や戻り値の形式が変わる

1. **`:one`**: クエリが単一の結果を返す場合に使用する。生成される関数は単一の結果を取得し、それを構造体として返す。
   - `:one`: 単一の結果を返すクエリ

2. **`:many`**: クエリが複数の結果を返す場合に使用する。生成される関数は結果のスライスを返す。
   - `:many`: 複数の結果を返すクエリ

3. **`:exec`**: クエリが結果を返さず、実行のみを行う場合に使用する。例えば、`INSERT`、`UPDATE`、`DELETE`などのクエリに対して使用する。
   - `:exec`: 実行のみを行うクエリ（結果を返さない）

4. **`:execrows`**: クエリが影響を受ける行数（`affectedRows`）を返す場合に使用する。通常の`exec`と同様に実行されるが、影響を受けた行数も返す。
   - `:execrows`: 実行後に影響を受ける行数を返すクエリ

5. **`:copy`**: PostgreSQLの`COPY`コマンドを使用する場合に使用する。この形式は特定のデータベースエンジンに依存する。
   - `:copy`: COPYコマンドを実行するクエリ

### `name`の使用例

#### :one

クエリが単一の結果を返す場合に使用

```sql
-- name: GetUserByID :one
SELECT id, name, email
FROM users
WHERE id = $1;
```

```go
func (q *Queries) GetUserByID(ctx context.Context, id int32) (User, error) {
    row := q.db.QueryRowContext(ctx, getUserByID, id)
    var i User
    err := row.Scan(&i.ID, &i.Name, &i.Email)
    return i, err
}
```

#### :many

クエリが複数の結果を返す場合に使用

```sql
-- name: ListUsers :many
SELECT id, name, email
FROM users;
```

```go
func (q *Queries) ListUsers(ctx context.Context) ([]User, error) {
    rows, err := q.db.QueryContext(ctx, listUsers)
    if err != nil {
        return nil, err
    }
    defer rows.Close()

    var items []User
    for rows.Next() {
        var i User
        if err := rows.Scan(&i.ID, &i.Name, &i.Email); err != nil {
            return nil, err
        }
        items = append(items, i)
    }
    if err := rows.Err(); err != nil {
        return nil, err
    }
    return items, nil
}
```

#### :exec

クエリが結果を返さず、実行のみを行う場合に使用

```sql
-- name: UpdateUserEmail :exec
UPDATE users
SET email = $2
WHERE id = $1;
```

```go
func (q *Queries) UpdateUserEmail(ctx context.Context, id int32, email string) error {
    _, err := q.db.ExecContext(ctx, updateUserEmail, id, email)
    return err
}
```

#### :execrows

クエリ実行後に影響を受ける行数を返す場合に使用

```sql
-- name: DeleteUser :execrows
DELETE FROM users
WHERE id = $1;
```

```go
func (q *Queries) DeleteUser(ctx context.Context, id int32) (int64, error) {
    result, err := q.db.ExecContext(ctx, deleteUser, id)
    if err != nil {
        return 0, err
    }
    return result.RowsAffected()
}
```

#### :copy

PostgreSQLのCOPYコマンドを使用する場合に使用

```sql
-- name: CopyUsersToStaging :copy
COPY users
TO STDOUT WITH (FORMAT csv);
```

#### その他の指定方法 (重要)

クエリの実行結果をカスタムな構造体として受け取りたい場合など、特定のシチュエーションに対応するために、クエリメタデータにはカスタムの`ゴールデン型`も指定できる

```sql
-- name: CustomQuery :one
-- @gotype: CustomResult
SELECT ...
```

`gotype`注釈を使うことで、自分で定義したカスタム構造体にクエリの結果をマッピングすることができる。

詳細は[こちら](./query-metadata-gotype.md)
