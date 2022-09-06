# React Best Practice

## [10 React Best Practices You Need to Follow In 2022](https://www.makeuseof.com/must-follow-react-practices/)

1. Using Functional Components and Hooks Instead of Classes
2. Avoid Using State (If Possible)
    - bad
```
const [username, setusername] = useState('')
const [password, setpassword] = useState('')
```
    - good
```
const [user, setuser] = useState({})
```
3. Organize Files Related to the Same Component in One Folder
4. Avoid Using Indexes as Key Props
5. Opt for Fragments Instead of Divs Where Possible
```
const Button = () => {
 return <button>Display</button>;
};
```
6. Follow Naming Conventions
7. Avoid Repetitive Code
8. Use Object Destructuring For Props
    - bad
```
const Button = (props) => {
 return <button>{props.text}</button>;
};
```
    - good
```
const Button = ({text}) => {
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

