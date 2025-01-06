# pytest

pytestはPython 用 UnitTest モジュール。
`pytest-mock` を使ったモック化は、`return_value`で固定値を戻り値として返す方法と、`side_effect`で戻り値の振る舞いを制御することができる。

## Example

### Test 部

[tests/xxx/test_xx.py]

```py
class TestXXXX:
    # PUT request to the /api/v1/me/should-send-sos-notification endpoint の Test
    async def test_put_xxxx_リクエストが成功する(
        self: Any, async_client_mock_user: AsyncClient, mocker: Any
    ) -> None:
        # UserRepositoryImplクラスオブジェクトのupdate_notification()メソッドをmock化する
        mocker.patch.object(UserRepositoryImpl, "update_notification", return_value=None)
        # async_client_mock_user fixtureが、AsyncClient インスタンスを持っており、これによって
        # HTTP Putリクエストが発生する
        res = await async_client_mock_user.put(
            "/api/v1/system/notification", json={"notification": True}
        )
        assert res.status_code == 200
```

[tests/conftest.py]

```py
@pytest_asyncio.fixture(scope="function")
async def async_client_mock_user() -> AsyncGenerator[Any, Any]:
    app.dependency_overrides[get_current_user] = get_mock_user
    async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as ac:
        yield ac

@pytest_asyncio.fixture(scope="function")
def mock_update_firebase_user_password(mocker: Any) -> Any:
    # authクラスオブジェクトのupdate_user()メソッドをmock化する
    return mocker.patch.object(
        auth,
        "update_user",
        return_value=None,
    )
```

- mocker.patch.object()
  - クラスオブジェクトに対して、patch を適用して Mock 化する

### 実行部

[api/src/services/user.py]

おそらく、実際は、こちらがリクエストのエンドポイントとなる

```py
class UserService:
    def __init__(self, db: AsyncSession, database_repository: DatabaseRepository):
        self.db = db
        self.user_repository = database_repository.user_repository

    async def update_password(self, user: UserDto, last_password_updated_at: datetime, password: str) -> None:
        """update user's password by id"""

        # 指定されたidのユーザーのlast_password_updated_atの値を現在日時を更新
        # firebaseのパスワード変更処理失敗時にロールバック可能にするために先にDB変更を呼び出す（コミットしない）
        # TODO for test: Testにおいて、user_repositoryクラスオブジェクトの`update_last_password_updated_at`のmock化が必要
        await self.user_repository.update_last_password_updated_at(self.db, user.id, last_password_updated_at)
        # TODO for test: これは薄いラッパーで、次のauthを参照 (auth.update_userを呼び出しているので、mock化はこちら)
        update_firebase_user_password(user.firebase_uid, password=password)

    async def update_last_app_used_at(self, user: UserDto, last_app_used_at: datetime) -> None:
        """update user's last_app_used_at"""

        await self.user_repository.update_last_app_used_at(self.db, user.id, last_app_used_at)

    async def update_should_send_sos_notification(self, user: UserDto, should_send_sos_notification: bool) -> None:
        """update user's should_send_sos_notification"""
        # TODO for test: Testにおいて、user_repositoryクラスオブジェクトの`update_should_send_sos_notification`をmock化が必要
        await self.user_repository.update_should_send_sos_notification(self.db, user.id, should_send_sos_notification)
```

[api/src/core/auth.py]

```py
def update_firebase_user_password(firebase_uid: UUID, password: str) -> None:
    # from firebase_admin import auth, credentials

    # NOTE: https://firebase.google.com/docs/auth/admin/manage-users?hl=ja
    # TODO for test: Testにおいて、authクラスオブジェクトの`update_user`のmock化が必要
    auth.update_user(firebase_uid, password=password)
```

## References

- [pytest-mock でモックを使ってみる](https://dev.classmethod.jp/articles/pytest-mock/)
