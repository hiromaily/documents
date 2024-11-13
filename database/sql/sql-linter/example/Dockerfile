FROM python:3.13-slim

WORKDIR /workspace
COPY .sqlfluff .

RUN pip install --no-cache-dir sqlfluff

ENTRYPOINT ["sqlfluff"]
