# Bash スクリプト

- [シェルスクリプトを学ぶ人のための「新しい UNIX 哲学」 〜 ソフトウェアツールという考え方](https://qiita.com/ko1nksm/items/c55d067b55bbd561df11)

## 基本構文とテクニック

1. **Shebang（シバン）行**:
   スクリプトの最初の行に`#!`で始まる行を追加して、使用するインタプリタを指定する。一般的な Bash スクリプトのシバン行は次の通り。

   ```bash
   #!/bin/bash
   ```

2. **コメントの追加**:
   スクリプト内にコメントを入れることで、後から読むときに理解しやすくする。

   ```bash
   # これはコメント
   echo "Hello, World!"
   ```

3. **変数の使用**:
   単純な変数の定義と使用。

   ```bash
   NAME="Alice"
   echo "Hello, $NAME"
   ```

4. **コマンドの出力を変数に格納**:
   コマンドの出力を変数に代入するにはバッククォート(`` ` ``)や`$(...)`を使う。

   ```bash
   DATE=$(date)
   echo "Today is $DATE"
   ```

5. **条件分岐（if 文）**:

   ```bash
   if [ "$NAME" = "Alice" ]; then
     echo "Hi, Alice!"
   else
     echo "Who are you?"
   fi
   ```

6. **ループ処理**:

   - `for`ループ

     ```bash
     for i in {1..5}; do
       echo "Iteration $i"
     done
     ```

   - `while`ループ

     ```bash
     COUNTER=0
     while [ $COUNTER -lt 5 ]; do
       echo "Counter: $COUNTER"
       ((COUNTER++))
     done
     ```

7. **関数の定義**:
   関数を使うことで、コードの再利用性が上がる。

   ```bash
   greet() {
     echo "Hello, $1"
   }
   greet "Alice"
   ```

8. **コマンドライン引数の処理**:

   ```bash
   echo "First argument: $1"
   echo "Second argument: $2"
   ```

9. **エラーハンドリング**:
   スクリプトの途中でエラーが発生した場合に処理を中断するために、`set -e`を使う。

   ```bash
   set -e
   ```

10. **ログの記録**:
    標準出力と標準エラーをファイルに記録する。

    ```bash
    exec >logfile.txt 2>&1
    ```

11. **配列の使用**:
    Bash では配列も使える。

    ```bash
    FRUITS=("apple" "banana" "cherry")
    echo "First fruit: ${FRUITS[0]}"
    echo "All fruits: ${FRUITS[@]}"
    ```

12. **ケース分岐（case 文）**:
    複数の条件を簡潔に処理するために`case`文を使用する。

    ```bash
    case "$NAME" in
      "Alice")
        echo "Hello, Alice!"
        ;;
      "Bob")
        echo "Hello, Bob!"
        ;;
      *)
        echo "Who are you?"
        ;;
    esac
    ```

13. **リダイレクトとパイプライン**:
    コマンドの出力を別のコマンドの入力として使用する場合にパイプラインを使用する。

    ```bash
    ls -l | grep "^d"
    ```

## References

- [いい加減シェルスクリプトで `[ $? -eq 0 ]` や `[ $? -ne 0 ]` なんて エラー処理を書くのはやめよう！](https://qiita.com/ko1nksm/items/09bd50e51cc8663a4f0e)
