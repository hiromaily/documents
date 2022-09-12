# Architecture
- [react-patterns](https://github.com/topics/react-patterns)
- [File Structure](https://reactjs.org/docs/faq-structure.html)

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

## Pattern 2
- [bulletproof-react](https://github.com/alan2207/bulletproof-react)

### Notes
- Use Absolute Imports
```
import { Button } from '@components';
```
- Separate business logic from UI
- Avoiding creating a single Context for everything

### Handling Component Re-Renderings
- [5 Ways to Avoid React Component Re-Renderings](https://blog.bitsrc.io/5-ways-to-avoid-react-component-re-renderings-90241e775b8c)

