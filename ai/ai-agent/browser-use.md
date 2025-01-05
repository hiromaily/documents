# Browser Use

AI エージェントがブラウザを自動で操作するための AI ツール。LangChain を基盤としたオープンソースプロジェクトであり、シンプルなプロンプトによってウェブブラウザを完全に制御するエージェントを提供する。

[Github: browser-use](https://github.com/browser-use/browser-use)

## 主な特徴

1. **自動ブラウザ操作**: AI エージェントがウェブページの要素を認識し、操作を自動で実行する。
2. **ローカル環境で実行可能**: 環境変数に API キーを設定することで、ローカル環境で実行可能。
3. **LLM との連携**: GPT-4、Llama 2、Claude 3 などの LLM との連携が可能。

## 使用方法

1. **インストール**:

   ```sh
   pip install browser-use
   pip install playwright
   playwright install
   ```

2. **API キー設定**:

   ```sh
   OPENAI_API_KEY=your_openai_api_key
   ANTHROPIC_API_KEY=your_anthropic_api_key
   ```

3. **環境変数の設定**: `.env`ファイルを作成し、API キーを記述する。

4. **サンプルコード**:

   ```python
   from langchain_openai import ChatOpenAI
   from browser_use import Agent
   import asyncio

   async def main():
       agent = Agent(
           task="東京都のおすすめの焼肉屋を調べてください。",
           llm=ChatOpenAI(model="gpt-4o-mini"),
       )
       result = await agent.run()
       print(result)

   asyncio.run(main())
   ```

## 機能概要

1. **ウェブ要素の抽出**: ボタンやリンクなどの要素の認識と操作が可能。
2. **自動化機能**: 複数のブラウザタブを同時に管理し、クリックされた要素の追跡と再利用可能な操作履歴(XPath 抽出)が可能。
3. **カスタム可能性**: ファイル保存、データベース操作、通知などオリジナルアクションの追加が可能です。ヘッドレスモードやセキュリティ無効化などのブラウザ設定のカスタマイズも可能。
4. **堅牢性と効率性**: 自動でエラーの修正が可能で、並列エージェントの実行で処理効率を向上する。
5. **AI モデルとの互換性**: GPT-4、Claude 3、Llama 2 など、多様な LLM と連携可能。

## References

- [AI Agent がブラウザを操作する「Browser Use」を試してみよう！](https://note.com/jolly_dahlia842/n/nb09c594eae7f)
- [これはもう実質 AGI では? AI が勝手にブラウザを操作していろいろやってくれちゃう BrowserUse が爆誕](https://note.com/shi3zblog/n/n960fc72b36e9)
- [browser-use の基礎理解](https://zenn.dev/gunjo/articles/8450e69537dbb6)
- [browser-use やばいです](https://qiita.com/Syoitu/items/5aa84b5d8c6047c4d41b)
- [browser-use によるブラウザ操作自動化のサンプル集](https://zenn.dev/gunjo/articles/2f6898b846d371)
