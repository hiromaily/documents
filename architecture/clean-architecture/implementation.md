# よく使う実装は、Layer の何に該当するか？

## Repository

例えば、usecase 層があり、repository I/F に依存しているとする

```go
type SampleUsecaser interface {
  // parameter and response may be changed as specification
  DoFirst(ctx context.Context) (response.Response, error)
  DoSecond(ctx context.Context) (response.Response, error)
}

type SampleUsecase struct {
  logger   logger.Logger
  addressRepo repository.AddressRepositorier
}
```

repository Interface は以下の通り

```go
type AddressRepositorier interface {
  GetAll(accountType account.AccountType) ([]*models.Address, error)
  GetAllAddress(accountType account.AccountType) ([]string, error)
}
```

実装は以下の通り

```go
// AddressRepository is repository for address table
type AddressRepository struct {
  dbConn       *sql.DB
  tableName    string
  logger       *zap.Logger
}

// NewAddressRepository returns AddressRepository object
func NewAddressRepository(dbConn *sql.DB, logger *zap.Logger) *AddressRepository {
  return &AddressRepository{
    dbConn:       dbConn,
    tableName:    "address",
    logger:       logger,
  }
}

// GetAll returns all records by account
func (r *AddressRepository) GetAll(accountType account.AccountType) ([]*models.Address, error) {
  // sql := "SELECT * FROM %s WHERE account=%s;"
  ctx := context.Background()

  items, err := models.Addresses(
    qm.Where("coin=?", r.coinTypeCode.String()),
    qm.And("account=?", accountType.String()),
  ).All(ctx, r.dbConn)
  if err != nil {
    return nil, errors.Wrap(err, "failed to call models.Addresss().All()")
  }
  return items, nil
}
```

このとき、Repository (AddressRepository を実装した AddressRepository) は、`Interface Adapter (Controllers, Presenters, Gateways)`レイヤーに該当する。
例えば、上記の`GetAll()`は Interface を介して Usecase 層から呼ばれる。そしてこの`GetAll()`内で`models.Addresses(..).All(..)`という DB ライブラリの実装を呼び出している。

## Logger

logger Interface は以下の通り

```go
type Logger interface {
  // FIXME: optimize for slog //nolint:golint
  Debug(msg string, args ...any)
  Info(msg string, args ...any)
  Warn(msg string, args ...any)
  Error(msg string, args ...any)
}
```

実装は以下の通り

```go
package logger

import (
  "log/slog"
  "os"
)

type SlogLogger struct {
  log *slog.Logger
}

func NewLogger() *SlogLogger {
  return &SlogLogger{
    log: slog.New(slog.NewJSONHandler(os.Stdout, nil)),
  }
}

// Debug
func (s *SlogLogger) Debug(msg string, args ...any) {
  s.log.Debug(msg, args...)
}
```

このとき、Logger (Logger を実装した SlogLogger) も、`Interface Adapter (Controllers, Presenters, Gateways)`レイヤーに該当する。
例えば、上記の`Debug()`は Interface を介して Usecase 層から呼ばれる。そしてこの`Debug()`内で`log.Debug()`という slog 標準ライブラリの実装を呼び出している。
