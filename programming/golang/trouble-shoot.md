# Trouble Shoot

## Import cycle not allowed

循環参照が原因。linterでエラーが出る場合、`go vet ./...`を実行すると参照しているpathが表示される

[Stackoverflow: Import cycle not allowed](https://stackoverflow.com/questions/28256923/import-cycle-not-allowed)
