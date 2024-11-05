# MySQLの ENUM 列挙型

- 内部的には整数として保持される
- ENUM 型を独立して定義できず、テーブルに紐づけられる

```sql
CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  price ENUM('cheap', 'reasonable', 'expensive')
);
```
