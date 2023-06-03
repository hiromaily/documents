# Error Tracking

## Front-end Logging 収集 (エラー監視)

### 条件

- React/Next.js との連携が容易なこと
- Open Source
- React/Next.js に特化した Docs が整備されているとなお良い
- 高機能である必要性はない(ほぼ機能的に横並び)と思うので、ランニングコストの面で選んでもいいかもしれない。
- self-hosted 可能なサービスであれば、dev 環境でも使える
- 使用する SaaS が増えると管理がしづらい？その場合、Datadog に集約させる？

### Services

- [Sentry](https://sentry.io/for/error-monitoring/)
  - Free for Developer
  - $26/mo for Team
- [Bugsnag](https://www.bugsnag.com/)
  - Free for small teams (Business でも使える??)
- [Rollbar](https://rollbar.com/)
  - Free plan: 5,000 error events monthly
  - $12.50/mo for Essentials
- Airbrake
- TrackJS
- CatchJS
- LogRocket
- [Datadog](https://www.datadoghq.com/product/error-tracking/)

### References

- [npm trende: bugsnag vs bugsnag-js vs rollbar vs sentry vs trackjs](https://npmtrends.com/bugsnag-vs-bugsnag-js-vs-rollbar-vs-sentry-vs-trackjs)
- [Compare Sentry vs Bugsnag vs Raygun vs Rollbar](https://www.saasworthy.com/compare/sentry-vs-bugsnag-vs-raygun-vs-rollbar?pIds=3483,3485,3490,9272)
- [10 Best Error Monitoring Tools to Use in 2023](https://rollbar.com/blog/best-error-monitoring-tools/)
