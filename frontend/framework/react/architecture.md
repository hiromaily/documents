# Architecture
- [react-patterns](https://github.com/topics/react-patterns)

## Pattern 1 
- [React Architecture Patterns for Your Projects](https://blog.openreplay.com/react-architecture-patterns-for-your-projects)
- [React Folder Structure in 5 Steps](https://www.robinwieruch.de/react-folder-structure/)

### Structure
```
└── /src
    ├── /assets
    ├── /components
    ├── /context
    ├── /hooks
    ├── /pages
    ├── /services
    ├── /utils
    └── App.js
    ├── index.js
```
- services ... For API
- hooks ... Custom Hooks
- pages ... For UI

### Notes
- Use Absolute Imports
```
import { Button } from '@components';
```
- Separate business logic from UI
- Avoiding creating a single Context for everything

## Pattern 2
- [bulletproof-react](https://github.com/alan2207/bulletproof-react)