# Structure

## As Architectures

### Model-View-Controller (MVC)

- Separates the application into three interconnected components
  - Model (data logic)
  - View (UI)
  - Controller (handles user input)

### Model-View-ViewModel (MVVM)

- Similar to MVC but focuses on the View and introduces ViewModel to manage and abstract the View's state and logic

### Flux Architecture

- A unidirectional data flow pattern with actions, dispatchers, stores, and views/components

### Model-View-Intent (MVI)

- Emphasizes a unidirectional data flow, where the intent of the user is captured, and the model updates based on these intents.

### Component-Based Architecture

- Focuses on building applications as a collection of reusable, self-contained UI components.

### Micro Frontends

- Involves breaking down a monolithic frontend into smaller, independently deployable and manageable parts.

### Domain-Driven Design (DDD) in Frontend

- Aligns the code structure with the business domain, emphasizing domain logic and models.

### Serverless Architecture

- Backend logic and functions are hosted in the cloud and triggered by frontend events or requests.

## Common Component-Based Patterns

- Container Component / Presentational Component Pattern
- Higher-Order Components (HOCs)
- Render Props
- Containerless Component
- Smart Components / Dumb Components
- Atomic Design
- Component Composition

## Feature-Sliced Design

- [Docs](https://feature-sliced.design/)
