# LM Studio



## [LM Studio as a Local LLM API Server](https://lmstudio.ai/docs/app/api)

OpenAPI互換のEndpointが備わっているが、2024/3時点では以下

- `/v1/models`
- `/v1/chat/completions`
- `/v1/completions`
- `/v1/embeddings`


-[参考: OpenAI Compatibility endpoints](https://lmstudio.ai/docs/app/api/endpoints/openai)

   ```py
   from openai import OpenAI

   client = OpenAI(
     base_url="http://localhost:1234/v1"
   )   
   ```

## References

- [ローカルLLM時代到来！Gemma 3の導入・活用ガイド(LMStudio)](https://note.com/swiftwand/n/n7446b89763f0)
- [LM Studio REST API](https://lmstudio.ai/docs/app/api/endpoints/rest) (new, in beta)
- [TypeScript SDK](https://lmstudio.ai/docs/typescript) - lmstudio-js
- [Python SDK](https://lmstudio.ai/docs/python) - lmstudio-python
