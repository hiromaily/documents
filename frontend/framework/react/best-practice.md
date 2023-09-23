# React Best Practice

## [Airbnb JavaScript Style Guide](https://airbnb.io/javascript/react/)

- [Airbnb JavaScript Style Guide() : github](https://github.com/airbnb/javascript)
- [Airbnb React/JSX Style Guide: github](https://github.com/airbnb/javascript/tree/master/react)

## [10 React Best Practices You Need to Follow In 2022](https://www.makeuseof.com/must-follow-react-practices/)

1. Using Functional Components and Hooks Instead of Classes
2. Avoid Using State (If Possible)
   - bad

```tsx
const [username, setusername] = useState("");
const [password, setpassword] = useState("");
```

    - good

```tsx
const [user, setuser] = useState({});
```

3. Organize Files Related to the Same Component in One Folder
4. Avoid Using Indexes as Key Props
5. Opt for Fragments Instead of Divs Where Possible

```tsx
const Button = () => {
  return <button>Display</button>;
};
```

6. Follow Naming Conventions
7. Avoid Repetitive Code
8. Use Object Destructuring For Props
   - bad

```tsx
const Button = (props) => {
  return <button>{props.text}</button>;
};
```

- good

```tsx
const Button = ({ text }) => {
  return <button>{text}</button>;
};
```

9. Dynamically Render Arrays Using Map
10. Write Tests for Each React Component

## [The React Best Practices You Need To Follow In 2022](https://www.enprowess.com/blogs/react-best-practices/)

1. Use functional components
2. Keep your Components small and separate your functionalities
3. Always name your React components
4. Use JavaScript destructuring to remove redundancy
5. Always prefer passing objects
   - Passing an object instead of passing a set of primitive values
6. Use React developer tools
7. Conditional rendering practices
8. Use snippet libraries
9. Use prop-types library
   - [PropTypes](https://reactjs.org/docs/typechecking-with-proptypes.html)
10. Comment Code only where necessary
11. Code should execute as expected and be easily testable
12. Follow linting rules, break up long lines
13. Put CSS in JavaScript
    - [emotion](https://github.com/emotion-js/emotion)
    - [glamorous](https://glamorous.rocks/)

## [React Best Practices - Ways To Write Better Code in 2022](https://blog.nourdinedev.com/react-best-practices-2022/)

1. folder-structure
2. Code Structure
   - Maintain a structured import order
   - double quotes ("") or single quotes (''). maintain consistency
   - Divide the whole app into small components
   - Follow common naming conventions
   - Avoid Repetitive Code
   - Use Object Destructuring For Props
3. Use a linter
4. Extract reusable logic into custom hooks
5. Write a fragment when a div is not needed
   - bad

```tsx
return (
  <div>
    <h1>Hello!</h1>
    <p>
      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum odio
      odio, tempor non ipsum et, aliquam pharetra urna.
    </p>
  </div>
);
```

- good

```tsx
return (
  <>
    <h1>Hello!</h1>
    <p>
      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum odio
      odio, tempor non ipsum et, aliquam pharetra urna.
    </p>
  </>
);
```

6. Integrate Typescript
7. Test your code

## [React Best Practices – Tips for Writing Better React Code in 2022](https://www.freecodecamp.org/news/best-practices-for-react/)

1. Create a good folder-structure
2. Maintain a structured import order
3. Learn different component patterns
   - compound component pattern
4. Use a linter and follow its rules
5. Test your code
6. Integrate Typescript (or at least use default props and prop types)
7. Use lazy-loading / code splitting
8. Extract reusable logic into custom hooks
9. Handle errors effectively [Important]
   - React Error Boundary
   - Use try-catch to handle errors beyond boundaries
   - Use the react-error-boundary library (personal recommendation)
   - Logging errors
10. Keep your key prop unique across your whole app
11. Implement the useReducer hook earlier
12. Use shorthand for boolean props
13. Avoid curly braces for string props
14. Erase non-html attributes when spreading props
15. Use snippet extensions
16. Write a fragment when a div is not needed
17. Integrate self closing tags when no children are needed
18. Follow common naming conventions
19. Sanitize your code to prevent XSS Attacks
