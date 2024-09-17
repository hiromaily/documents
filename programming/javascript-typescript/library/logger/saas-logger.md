# SaaS Logger

## Datadog

- [DataDog/browser-sdk](https://github.com/DataDog/browser-sdk)
  - [browser-logs](https://www.npmjs.com/package/@datadog/browser-logs)
  - Datadog にデータを収集するためのライブラリ
- [Browser Log Collection](https://docs.datadoghq.com/logs/log_collection/javascript/)

  - Client 側で API Key は使えず[client token](https://docs.datadoghq.com/account_management/api-app-keys/#client-tokens)を使ってアクセスする

### How to use

- 初期設定

```js
import { datadogLogs } from "@datadog/browser-logs";

datadogLogs.init({
  clientToken: "<DATADOG_CLIENT_TOKEN>",
  site: "<DATADOG_SITE>",
  forwardErrorsToLogs: true,
  sessionSampleRate: 100,
});
```

- 利用

```js
import { datadogLogs } from '@datadog/browser-logs'

datadogLogs.logger.info('Button clicked', { name: 'buttonName', id: 123 })

try {
  ...
  throw new Error('Wrong behavior')
  ...
} catch (ex) {
  datadogLogs.logger.error('Error occurred', { team: 'myTeam' }, ex)
}
```

## Sentry

- [Sentry Docs: Browser Javascript](https://docs.sentry.io/platforms/javascript/)
- [Official Sentry SDK for Browsers](https://www.npmjs.com/package/@sentry/browser)

### How to use

- 初期設定

```js
import * as Sentry from "@sentry/browser";

Sentry.init({
  dsn: "https://examplePublicKey@o0.ingest.sentry.io/0",

  // Alternatively, use `process.env.npm_package_version` for a dynamic release version
  // if your build tool supports it.
  release: "my-project-name@2.3.12",
  integrations: [new Sentry.BrowserTracing(), new Sentry.Replay()],

  // Set tracesSampleRate to 1.0 to capture 100%
  // of transactions for performance monitoring.
  // We recommend adjusting this value in production
  tracesSampleRate: 1.0,

  // Set `tracePropagationTargets` to control for which URLs distributed tracing should be enabled
  tracePropagationTargets: ["localhost", /^https:\/\/yourserver\.io\/api/],

  // Capture Replay for 10% of all sessions,
  // plus for 100% of sessions with an error
  replaysSessionSampleRate: 0.1,
  replaysOnErrorSampleRate: 1.0,
});
```

- 利用

```js
import * as Sentry from "@sentry/browser";

try {
  aFunctionThatMightFail();
} catch (err) {
  Sentry.captureException(err);
}
```
