# OpenAI Python Library

- [github](https://github.com/openai/openai-python)
- [api](https://github.com/openai/openai-python/blob/main/api.md)

## [Response API](https://platform.openai.com/docs/api-reference/responses)

responses.create メソッド

```py
import os
from openai import OpenAI

client = OpenAI(
    # This is the default and can be omitted
    api_key=os.environ.get("OPENAI_API_KEY"),
)

response = client.responses.create(
    model="gpt-4o",
    instructions="You are a coding assistant that talks like a pirate.",
    input="How do I check if a Python object is an instance of a class?",
)

print(response.output_text)
```

## [Chat Completions API](https://platform.openai.com/docs/api-reference/chat)

```py
from openai import OpenAI

client = OpenAI()

completion = client.chat.completions.create(
    model="gpt-4o",
    messages=[
        {"role": "developer", "content": "Talk like a pirate."},
        {
            "role": "user",
            "content": "How do I check if a Python object is an instance of a class?",
        },
    ],
)

print(completion.choices[0].message.content)
```
