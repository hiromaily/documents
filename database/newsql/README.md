# NewSQL

NoSQL の柔軟性と SQL データベースの強力な機能を組み合わせた`分散データベース`。NewSQL は、ACID トランザクションや SQL による複雑なクエリーをサポートすることで、NoSQL の弱点であるデータの一貫性や性能の課題を解決している。
しかし、クエリのスループット(一定時間あたりのデータ転送量)を出すためにレイテンシ(通信の遅延時間)を犠牲にしているので本当にトレードオフを解消はしていない、などの問題が指摘されている。

![db-comparison](https://github.com/hiromaily/documents/raw/main/images/db-comparison.webp "db-comparison")

## NewSQL の種類

- [CockroachDB](https://www.cockroachlabs.com/)
  - Netflix でも利用されている
- [Google Spanner](https://cloud.google.com/spanner)
- [TiDB](https://github.com/pingcap/tidb)
  - TiDB is an open-source, cloud-native, distributed, MySQL-Compatible database for elastic scale and real-time analytics.
  - Star: 36.8k
- [YugabyteDB](https://www.yugabyte.com/)
  - PostgreSQL 互換の分散 SQL データベース

## References

- [NewSQL はデータベースに革命を起こすか - Netflix における CockroachDB のユースケース](https://note.com/mickmack/n/n45ded3a4e342)
