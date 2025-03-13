# Project structure

```txt
project_root/
├── src/
│   └── your_package/
│       ├── __init__.py
│       ├── main.py
│       ├── api/
│       │   ├── __init__.py
│       │   ├── routes.py
│       │   └── handlers/
│       ├── core/
│       │   ├── __init__.py
│       │   ├── models.py
│       │   └── services/
│       ├── database/
│       │   ├── __init__.py
│       │   ├── models.py
│       │   └── migrations/
│       ├── utils/
│       │   ├── __init__.py
│       │   └── helpers.py
│       └── config/
│           ├── __init__.py
│           └── settings.py
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── docs/
│   ├── api/
│   ├── user_guide/
│   └── developer_guide/
├── scripts/
│   ├── dev_setup.sh
│   └── deploy.sh
├── .github/
│   └── workflows/
│       └── ci.yml
├── .gitignore
├── README.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
├── requirements/
│   ├── base.txt
│   ├── dev.txt
│   └── prod.txt
├── setup.py
├── pyproject.toml
└── Dockerfile
```
