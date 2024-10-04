# Extension: postgis

PostGIS は、PostgreSQL に地理空間データサポートを追加する拡張機能で、地理空間データの格納、解析、および操作に利用される。この拡張機能を使うことで、地理情報システム（GIS）のデータを PostgreSQL データベース内で直接処理することができる。

以下のようにして PostGIS を有効化する

```sql
CREATE EXTENSION postgis;
```

このコマンドの実行によって、PostGIS の機能が使用可能にな ry。PostGIS は多くの機能とデータ型を提供している。

## 主なデータ型

1. **`geometry`**:
   通常の 2D または 3D 空間における地理空間オブジェクトを表現する

   ```sql
   SELECT ST_GeomFromText('POINT(1 2)');
   ```

2. **`geography`**:
   地球を球体として取り扱うため、長距離の計算においてより正確

   ```sql
   SELECT ST_GeographyFromText('SRID=4326;POINT(-71.060316 48.432044)');
   ```

## 主な関数

### 1. ジオメトリ生成関数

- **`ST_MakePoint`**:
  指定した座標から点を生成する

  ```sql
  SELECT ST_MakePoint(1, 2);
  ```

- **`ST_GeomFromText`**:
  WKT（Well-Known Text）からジオメトリを生成する

  ```sql
  SELECT ST_GeomFromText('POINT(1 2)');
  ```

### 2. ジオメトリ変換関数

- **`ST_Transform`**:
  ジオメトリを別の SRID（Spatial Reference System Identifier）に変換する

  ```sql
  SELECT ST_Transform(geom, 4326)
  FROM mygeotable;
  ```

### 3. 空間演算関数

- **`ST_Intersection`**:
  二つのジオメトリの交差部分を返す

  ```sql
  SELECT ST_Intersection(geom1, geom2)
  FROM geotable;
  ```

- **`ST_Buffer`**:
  ジオメトリの周囲にバッファ領域を作成する

  ```sql
  SELECT ST_Buffer(geom, 10)
  FROM geotable;
  ```

### 4. 空間リレーション関数

- **`ST_Contains`**:
  一つのジオメトリが他のジオメトリを含むかをチェックする

  ```sql
  SELECT ST_Contains(geom1, geom2)
  FROM geotable;
  ```

- **`ST_Within`**:
  一つのジオメトリが他のジオメトリ内に存在するかをチェックする

  ```sql
  SELECT ST_Within(geom1, geom2)
  FROM geotable;
  ```

### 5. 空間測定関数

- **`ST_Area`**:
  ジオメトリの面積を計算する

  ```sql
  SELECT ST_Area(geom)
  FROM geotable;
  ```

- **`ST_Distance`**:
  二つのジオメトリ間の最短距離を計算する

  ```sql
  SELECT ST_Distance(geom1, geom2)
  FROM geotable;
  ```

## インデックスの使用

PostGIS は、ジオメトリデータに対して効率的なクエリを実行するために、`GiST`（Generalized Search Tree）インデックスを使用する。以下に、ジオメトリカラムに対するインデックスの作成方法を示す

```sql
CREATE INDEX geom_idx ON geotable USING GIST(geom);
```

## 例: PostGIS の使用例

以下に、PostGIS を活用した実際のクエリの例を示す。この例では、特定の点の周囲 500 メートル以内にあるジオメトリを検索している

```sql
-- テーブルの作成
CREATE TABLE places (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    geom GEOMETRY(Point, 4326)
);

-- データの挿入
INSERT INTO places (name, geom)
VALUES ('Place A', ST_GeomFromText('POINT(10 10)', 4326)),
       ('Place B', ST_GeomFromText('POINT(15 10)', 4326)),
       ('Place C', ST_GeomFromText('POINT(12 11)', 4326));

-- GiSTインデックスの作成
CREATE INDEX places_geom_idx ON places USING GIST(geom);

-- 特定の点の周囲500メートル以内のジオメトリを検索
SELECT name
FROM places
WHERE ST_DWithin(geom, ST_GeomFromText('POINT(10 10)', 4326), 500);
```

このクエリは、指定された点（10, 10）から 500 メートル以内にある全ての地点を検索する

PostGIS は非常に強力で、地理情報システム（GIS）のデータを扱う多くの機能を提供する。これらの機能を駆使することで、複雑な地理空間データの解析が容易になる。拡張をインストールした後は、これらの関数やデータ型を使いこなして、様々な空間クエリを実行できるようになる
