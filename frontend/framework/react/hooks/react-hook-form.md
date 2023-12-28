# React Hook Form

- フォームの Validation ライブラリで、input 要素に入力した値の取得や様々な Validation が可能
- Validation には、`Yup`や`Zod`を使うこともできる

## References

- [Official](https://react-hook-form.com/)
- [React Hook Form の基本を理解してフォームを作成してみよう](https://reffect.co.jp/react/react-hook-form)
- [React Hook Form でも再描画に気を付ける](https://zenn.dev/takepepe/articles/rhf-usewatach)

### [API](https://react-hook-form.com/docs)

#### [useForm](https://react-hook-form.com/docs/useform)

useForm は、フォームを簡単に管理するためのカスタム・フック。オプションの引数として 1 つのオブジェクトを受け取る。

```tsx
const { register, handleSubmit } = useForm();
```

##### [register メソッド](https://react-hook-form.com/docs/useform/register)

このメソッドでは、input または select 要素を登録し、React Hook Form にバリデーションルールを適用できる。バリデーションルールはすべて HTML 標準に基づいており、独自のバリデーションメソッドも使用できる。

```tsx
<input id="email" {...register("email")} />
```

#### [useFormContext](https://react-hook-form.com/docs/useformcontext)

useFormContext は、深くネストされた構造体で props ではなく、context として使用することを想定している

#### [useWatch](https://react-hook-form.com/docs/usewatch)

Watch API(おそらく、useForm の戻り値に含まれる`watch`) と同様の動作をするが、カスタムフックレベルでの再レンダリングが分離され、アプリケーションのパフォーマンスが向上する可能性がある。

#### [useFormState](https://react-hook-form.com/docs/useformstate)

#### [useFieldArray](https://react-hook-form.com/docs/usefieldarray)
