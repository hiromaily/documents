# Slices

[slices](https://pkg.go.dev/slices)

Slice の様々な機能を持つ。Sort 機能もこちらに実装されているが、`sort`パッケージとの使い分けについては要検証。
`BinarySearchFunc`も興味深い。

## Note

`"golang.org/x/exp/slices"`を使っているサイトもあるが、この記述は古いので注意

## メソッド一覧

- func All[Slice ~[]E, E any](s Slice) iter.Seq2[int, E]
- func AppendSeq[Slice ~[]E, E any](s Slice, seq iter.Seq[E]) Slice
- func Backward[Slice ~[]E, E any](s Slice) iter.Seq2[int, E]
- func BinarySearch[S ~[]E, E cmp.Ordered](x S, target E) (int, bool)

  ```go
    names := []string{"Alice", "Bob", "Vera"}
    n, found := slices.BinarySearch(names, "Vera")
    fmt.Println("Vera:", n, found) // Vera: 2 true
  ```

- func BinarySearchFunc[S ~[]E, E, T any](x S, target T, cmp func(E, T) int) (int, bool)
- func Chunk[Slice ~[]E, E any](s Slice, n int) iter.Seq[Slice]
- func Clip[S ~[]E, E any](s S) S
  - Slice から使われていない capacity を削除する
- func Clone[S ~[]E, E any](s S) S
  - shallow clone
- func Collect[E any](seq iter.Seq[E]) []E
- func Compact[S ~[]E, E comparable](s S) S
- func CompactFunc[S ~[]E, E any](s S, eq func(E, E) bool) S
- func Compare[S ~[]E, E cmp.Ordered](s1, s2 S) int
- func CompareFunc[S1 ~[]E1, S2 ~[]E2, E1, E2 any](s1 S1, s2 S2, cmp func(E1, E2) int) int
- func Concat[S ~[]E, E any](slices ...S) S
- func Contains[S ~[]E, E comparable](s S, v E) bool
- func ContainsFunc[S ~[]E, E any](s S, f func(E) bool) bool
- func Delete[S ~[]E, E any](s S, i, j int) S
- func DeleteFunc[S ~[]E, E any](s S, del func(E) bool) S
- func Equal[S ~[]E, E comparable](s1, s2 S) bool
- func EqualFunc[S1 ~[]E1, S2 ~[]E2, E1, E2 any](s1 S1, s2 S2, eq func(E1, E2) bool) bool
- func Grow[S ~[]E, E any](s S, n int) S
- func Index[S ~[]E, E comparable](s S, v E) int
- func IndexFunc[S ~[]E, E any](s S, f func(E) bool) int
- func Insert[S ~[]E, E any](s S, i int, v ...E) S
- func IsSorted[S ~[]E, E cmp.Ordered](x S) bool
- func IsSortedFunc[S ~[]E, E any](x S, cmp func(a, b E) int) bool
- func Max[S ~[]E, E cmp.Ordered](x S) E
- func MaxFunc[S ~[]E, E any](x S, cmp func(a, b E) int) E
- func Min[S ~[]E, E cmp.Ordered](x S) E
- func MinFunc[S ~[]E, E any](x S, cmp func(a, b E) int) E
- func Repeat[S ~[]E, E any](x S, count int) S
- func Replace[S ~[]E, E any](s S, i, j int, v ...E) S
- func Reverse[S ~[]E, E any](s S)
- func Sort[S ~[]E, E cmp.Ordered](x S)
- func SortFunc[S ~[]E, E any](x S, cmp func(a, b E) int)
- func SortStableFunc[S ~[]E, E any](x S, cmp func(a, b E) int)
- func Sorted[E cmp.Ordered](seq iter.Seq[E]) []E
- func SortedFunc[E any](seq iter.Seq[E], cmp func(E, E) int) []E
- func SortedStableFunc[E any](seq iter.Seq[E], cmp func(E, E) int) []E
- func Values[Slice ~[]E, E any](s Slice) iter.Seq[E]

## よく使うメソッド

1. **Concat**: 複数のスライスを 1 つのスライスに結合する

   ```go
   slice1 := []int64{1, 2}
   slice2 := []int64{3, 4}
   newSlice := slices.Concat(slice1, slice2)
   fmt.Print(newSlice) // [1 2 3 4]
   ```

2. **Delete**: スライスから指定された範囲の要素を削除

   ```go
   digits := []int64{0, 1, 2, 3, 4}
   digits = slices.Delete(digits, 0, 1)
   fmt.Print(digits) // [1 2 3 4]
   ```

3. **Insert**: スライスの指定された位置に新しい要素を挿入する
   ```go
   digits := []int64{1, 2, 3}
   digits = slices.Insert(digits, 0, 0)
   fmt.Print(digits) // [0 1 2 3]
   ```

4. **Chunk**: スライスを指定されたサイズずつのチャンクに分割

   ```go
   nums := []int{1, 2, 3, 4, 5, 6, 7}
   for chunk := range slices.Chunk(nums, 3) {
       fmt.Println(chunk)
   }
   ```

5. **Clone**: スライスのコピーを生成
   ```go
   s := []int{1, 2, 3}
   cloned := slices.Clone(s)
   fmt.Print(cloned) // [1 2 3]
   ```

6. **Contains**: スライスの中に指定した要素が存在するか探索
7. **ContainsFunc**: 指定した関数を満たす要素が存在する場合、そのインデックスを返す
8. **Index**: スライスの中に指定した要素が存在する場合、そのインデックスを返す
9. **IndexFunc**: 指定した関数を満たす要素が最初に現れるインデックスを返す
10. **Compact**: 連続する同じ要素を削除して、スライスをコンパクトにする
11. **CompactFunc**: 指定の関数を使用して要素を比較し、連続する同じ要素を削除して、スライスをコンパクトにする
12. **Grow**: スライスの容量を増やす
13. **Replace**: スライスの指定された範囲の要素を指定されたスライスで置換する
14. **Reverse**: スライスの要素の順序を反転する
15. **Clip**: スライスの未使用のキャパシティを取り除く

## コード例

```go
import (
    "slices"
)

// [Contains] sliceに含まれている値があるかどうか
var SuccessStatusCodes []int = []int{200, 202}
// check status code
if slices.Contains(SuccessStatusCodes, res.StatusCode) {
    // true
} else {
    // false
}

// [Chunk] 配列を第二パラメータで指定した数を最大要素数とする配列に分割する
nums := []int{1, 2, 3, 4, 5, 6, 7}
for chunk := range slices.Chunk(nums, 3) {
    fmt.Println(chunk)
    // [1 2 3]
    // [4 5 6]
    // [7]
}

for chunk := range slices.Chunk(nums, 2) {
    fmt.Println(chunk)
    // [1 2]
    // [3 4]
    // [5 6]
    // [7]
}

// 値が均等に配分された3個のSliceが作成される
res := splitSlice(nums, 3)
for _, v := range res {
    fmt.Println(v)
}

func splitSlice(nums []int, parts int) [][]int {
    length := len(nums)
    subSliceSize := length / parts
    remainder := length % parts

    result := make([][]int, 0, parts)
    start := 0

    for i := 0; i < parts; i++ {
        end := start + subSliceSize
        if remainder > 0 {
            end++
            remainder--
        }
        result = append(result, nums[start:end])
        start = end
    }

    return result
}
```

## References

- [Go Slice Tricks Cheat Sheet](https://ueokande.github.io/go-slice-tricks/)
