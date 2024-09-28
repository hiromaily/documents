# PythonのOpenAPIに対応したFramework

## [FastAPI](https://fastapi.tiangolo.com/)

FastAPIはPythonベースの非常に高速なWebフレームワークで、APIの構築と、OpenAPI Specification（およびSwagger UI）およびReDocを使ったAPIドキュメントの自動生成を簡単に行えることが特徴。FastAPIは、型アノテーションを使用してAPIエンドポイントの型安全性を保証し、高いパフォーマンスを提供する

### FastAPIの主な特徴

1. **自動ドキュメント生成**：
   - OpenAPIおよびReDocによるAPIドキュメントが自動生成され、Swagger UIを通じてインタラクティブなドキュメントを提供する。

2. **型安全性**：
   - Pydanticを使用してデータバリデーションと設定を行い、型アノテーションを活用して高い型安全性を実現する。

3. **高パフォーマンス**：
   - ASGI（Asynchronous Server Gateway Interface）をベースにしており、非常に高いパフォーマンスを発揮する。

4. **簡潔なコード**：
   - Pythonのシンプルさを保ちながら強力な機能を提供する。

### コード例

まず、`main.py`ファイルを作成し、FastAPIアプリケーションを定義

```python
from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

app = FastAPI()

class User(BaseModel):
    id: int
    name: str
    email: str

class CreateUserRequest(BaseModel):
    name: str
    email: str

users = [
    User(id=1, name="John Doe", email="john.doe@example.com"),
]

@app.get("/users", response_model=List[User])
async def get_users():
    return users

@app.get("/users/{user_id}", response_model=User)
async def get_user(user_id: int):
    for user in users:
        if user.id == user_id:
            return user
    return {"error": "User not found"}

@app.post("/users", response_model=User)
async def create_user(user: CreateUserRequest):
    new_user = User(id=len(users) + 1, name=user.name, email=user.email)
    users.append(new_user)
    return new_user
```

### 高度な設定

#### 認証とセキュリティ

FastAPIはOAuth2やJWT（JSON Web Tokens）などの認証メカニズムを簡単に組み込むことができる。例として、Bearerトークン認証を設定する方法を示す。

```python
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

def fake_decode_token(token):
    return {"sub": "user"}

@app.get("/users/me", response_model=User)
async def read_users_me(token: str = Depends(oauth2_scheme)):
    user = fake_decode_token(token)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid authentication credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
    return user
```

#### データベースとの統合

SQLAlchemyやTortoise ORMなどを使用してデータベースと統合できる。以下に、SQLAlchemyを使用してデータベースを統合する例を示す。

```python
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session

DATABASE_URL = "sqlite:///./test.db"

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

class UserModel(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    email = Column(String, index=True)

Base.metadata.create_all(bind=engine)

@app.get("/db_users", response_model=List[User])
async def get_db_users(db: Session = Depends(SessionLocal)):
    return db.query(UserModel).all()
```
