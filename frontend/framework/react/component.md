# Component

## コンポーネント開発
1. Presentational Component
  - 見た目を実装するコンポーネントで、渡されたpropsを元にUIを調整する
2. Container Component
  - デザインは実装せず、ビジネスロジックのみを担い、振る舞いを実装する
  - Hooksを持たせて、状態を使って表示内容を変える、APIコールなどの副作用を実行するなど
  - Contextを参照し、Presentational Componentへ表示に必要なデータを渡す
```tsx
import { useState, useCallback} from 'react'
import { Button } from './button'

// ポップアップを表示するためのフック
const usePopup = () {
  // 与えられたテキストを表示するポップアップを出現させる関数
  const cb = useCallback((text: string) => {
    prompt(text)
  }, [])
  return cb
}

type CountButtonProps = {
  label: string
  maximum: number
}

// クリックされた回数を表示するボタンを表示するコンポーネント
export const CountButton = (props: CountButtonProps) => {
  const { label, maximum } = props

  // アラートを表示させるためのフックを使う
  const displayPopup = usePopup()
  
  // カウントを保持する状態を定義する
  const [count, setCount] = useState(0)

  // ボタンが押されたときの挙動を定義する
  const onClick = useCallback(() => {
    // カウントを更新する
    const newCount = count + 1
    setCount(newCount)

    if (newCount >= maximum) {
      // アラートを出す
      displayPopup(`You have clicked ${newCount} times`)
    }
  }, [count, maximum])

  // 状態を元に表示に必要なデータを求める
  const disabled = count >= maximum
  const text = disabled
    ? 'Can not click any more'
    : `You have clicked ${count} times`

  // Presentational Componentを返す
  return {
    <Button disabled={disabled} onClick={onClick} label={label} text={text}>
  }
} 
```
