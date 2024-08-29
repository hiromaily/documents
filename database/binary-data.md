# バイナリデータの格納

標準SQLは、`BLOB`または`BINARY LARGE OBJECT`という、バイナリ列型を定義するが、PostgreSQLでは異なる。
MySQLの場合、`BLOB`型が存在する。

## データベースにバイナリとして画像を保存するメリット・デメリット

### メリット

- データの一貫性が保たれ、データベースのバックアップや復元が容易になる
- セキュリティの観点からもアクセス制御が容易になる
- トランザクション分離の問題が解決される


### デメリット

- データベースのサイズが大きくなり、パフォーマンスが低下する可能性がある
- 画像処理などの専門的な操作が難しくなる
- 画像の更新や変更が頻繁に行われる場合、データベースの負荷が増大する

- [You shouldn’t store your images/videos in a database](https://medium.com/ensias-it/you-shouldnt-store-your-images-videos-in-a-database-6a78ffa277b2)

## SQL Antipatterns: Phantom Files

ファイルのバイナリ情報をDBの内部に保存するのではなく、外部のファイルに置くというパターンこそがアンチパターンであり、データベースで画像を保存するべきという主張だが、ここで最も大切なことは「盲目的にアンチパターンを避けない」ということ

扱うファイルの数やサイズが小規模なものであれば、DBのトランザクションを利用して処理した方が、信頼性が高く実装コストも低くなることが期待できる。

## PostgreSQL

[PostgreSQL16: バイナリ列データ型](https://www.postgresql.jp/document/16/html/datatype-binary.html)

- `bytea`データ型はバイナリ列の保存を可能にする
- bytea型は入出力用に2つの書式をサポート
  - hex書式 (Default)
  - エスケープ書式

### Create文

```sql
CREATE TABLE image_box (id INTEGER PRIMARY KEY, dat BYTEA);
```

### 汎用ファイルアクセス関数

- `pg_read_binary_file`関数
  - ファイルの内容(bytea型)を返す

#### AES-256で暗号化かけたファイルを保存する例 (Golang)

`AWS`を使う場合は`KMS`で管理しているpasswordを使って、暗号化する

```go
package main

import (
	"bytes"
	"crypto/aes"
	"crypto/cipher"
	"crypto/rand"
	"crypto/sha256"
	"database/sql"
	"encoding/base64"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"

	_ "github.com/lib/pq"
)

// Encrypt function (same as in the previous example)
func Encrypt(data []byte, passphrase string) ([]byte, error) {
	block, err := aes.NewCipher([]byte(createHash(passphrase)))
	if err != nil {
		return nil, err
	}

	gcm, err := cipher.NewGCM(block)
	if err != nil {
		return nil, err
	}

	nonce := make([]byte, gcm.NonceSize())
	if _, err := io.ReadFull(rand.Reader, nonce); err != nil {
		return nil, err
	}

	ciphertext := gcm.Seal(nonce, nonce, data, nil)
	return ciphertext, nil
}

// createHash function (same as in the previous example)
func createHash(key string) string {
	hash := sha256.Sum256([]byte(key))
	return base64.URLEncoding.EncodeToString(hash[:])
}

// uploadHandler handles the image upload and encryption
func uploadHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != "POST" {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Parse the multipart form, the maximum upload size is set here
	err := r.ParseMultipartForm(10 << 20) // 10 MB limit
	if err != nil {
		http.Error(w, "Unable to parse form", http.StatusBadRequest)
		return
	}

	// Get the file from the form
	file, handler, err := r.FormFile("image")
	if err != nil {
		http.Error(w, "Error retrieving the file", http.StatusBadRequest)
		return
	}
	defer file.Close()

	// Print some information about the uploaded file
	fmt.Printf("Uploaded File: %+v\n", handler.Filename)
	fmt.Printf("File Size: %+v\n", handler.Size)
	fmt.Printf("MIME Header: %+v\n", handler.Header)

	// Read the file content into a buffer
	var buf bytes.Buffer
	_, err = io.Copy(&buf, file)
	if err != nil {
		http.Error(w, "Error reading the file", http.StatusInternalServerError)
		return
	}
	fileBytes := buf.Bytes()

	// Encrypt the image data
	password := "your-strong-password"
	encryptedData, err := Encrypt(fileBytes, password)
	if err != nil {
		http.Error(w, "Error encrypting the file", http.StatusInternalServerError)
		return
	}

	// Store encrypted image in the database
	connStr := "user=username dbname=mydb sslmode=disable password=mypassword"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		http.Error(w, "Error connecting to the database", http.StatusInternalServerError)
		return
	}
	defer db.Close()

	_, err = db.Exec("INSERT INTO images (image_data) VALUES ($1)", encryptedData)
	if err != nil {
		http.Error(w, "Error storing the file in the database", http.StatusInternalServerError)
		return
	}

	fmt.Fprintf(w, "File uploaded and stored successfully!")
}

func main() {
	http.HandleFunc("/upload", uploadHandler)

	// Start the server on port 8080
	fmt.Println("Server started at http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
```

### バイナリデータの出力

```sql
COPY (SELECT dat FROM image_box WHERE id = 1) TO '/tmp/output_image.jpg' WITH (FORMAT binary);
```
