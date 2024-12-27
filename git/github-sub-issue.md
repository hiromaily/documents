# GitHub Sub-issues

GitHub の「Sub issue」は、多くの場合、「Child Issue」として言及されることがある。これは、大きな課題（親Issue）を管理するために、その課題をより小さな、具体的な作業単位に分割する際に使用される。

## Sub-issuesの使用方法

1. **親Issueを作成する**:
    - 大きな課題やプロジェクト目標に対するIssueを作成。
      - 例: 「ウェブサイトのリニューアル」や「eコマース機能を追加する」など。

2. **タスクリストを作成する**:
    - 親Issueの説明欄に、タスクリストをMarkdownのチェックリスト形式で記述する。
      - 例:

         ```markdown
         ## To-Do
         - [ ] フロントエンドデザインの更新
         - [ ] APIの実装
         - [ ] ユーザーテストの実施
         ```

3. **Sub Issueを作成する**:
    - 各タスクを詳細に説明するために、個別のIssueを作成する。
    - Issue番号が生成されるので、それを元の親Issueのタスクリスト項目にリンクとして追加する。
      - 例:

         ```markdown
         ## To-Do
         - [ ] [フロントエンドデザインの更新](https://github.com/your-repo/your-project/issues/2)
         - [ ] [APIの実装](https://github.com/your-repo/your-project/issues/3)
         - [ ] [ユーザーテストの実施](https://github.com/your-repo/your-project/issues/4)
         ```

4. **進捗状況の管理**:
    - サブIssueを個別で管理し、各Issueが完了したタイミングでチェックリストの項目を更新する。
    - サブIssueがクローズされることで、親Issueの進捗が明確に把握できる。

## Sub Issueの利点

- **明確なタスク分割**: 大きなプロジェクトを管理しやすくするため、小さな作業単位に分割。
- **チームのコラボレーション**: 各メンバーが特定のサブIssueに取り組みやすくなる。
- **進捗追跡**: 親Issueの進捗が一目でわかる。

## Sub Issueの具体例

例えば、大きなプロジェクト「ウェブサイトのリニューアル」のIssueを立てたとする。そこに以下のようにサブIssueを作成して管理することができる：

```markdown
# ウェブサイトのリニューアル
## To-Do
- [ ] [トップページのデザイン更新](https://github.com/your-repo/your-project/issues/2)
- [ ] [バックエンドのAPI改修](https://github.com/your-repo/your-project/issues/3)
- [ ] [ユーザーテストの実施](https://github.com/your-repo/your-project/issues/4)
```

各Sub Issueに対して、詳細な説明や議論を行い、それぞれの進捗に基づいてチェックリストを更新する。

このようにしてSub Issueを管理することで、プロジェクト全体を効率的に進めることができる。

## References

- [GitHub の Sub-issues はいいぞ](https://product.st.inc/entry/2024/12/27/102310)
