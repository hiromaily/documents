# Pooling

## Javascript
```js
function makeRequest() {
  // Make your request here
  // For example, using Fetch API or XMLHttpRequest

  // Assuming the request returns a promise
  return fetch('https://api.example.com/status')
    .then(response => response.json())
    .then(data => {
      // Check the status of the response
      if (data.status === 'completed') {
        return data; // Return the completed response
      } else {
        // If the status is not completed, retry after a certain interval
        return new Promise(resolve => setTimeout(resolve, 1000)) // Retry after 1 second
          .then(makeRequest); // Make the request again
      }
    });
}

// Usage
makeRequest()
  .then(completedResponse => {
    // Handle the completed response
    console.log(completedResponse);
  })
  .catch(error => {
    // Handle errors
    console.error(error);
  });
```

## Typescript
```ts
async function makeRequest(): Promise<any> {
  while (true) {
    const response = await fetch('https://api.example.com/status');
    const data = await response.json();

    if (data.status === 'completed') {
      return data; // Return the completed response
    } else {
      await new Promise(resolve => setTimeout(resolve, 1000)); // Retry after 1 second
    }
  }
}

// Usage
makeRequest()
  .then(completedResponse => {
    // Handle the completed response
    console.log(completedResponse);
  })
  .catch(error => {
    // Handle errors
    console.error(error);
  });
```

## Typescript + React Hook
```ts
import React, { useState, useEffect } from 'react';

function usePoolingRequest(): any {
  const [completedResponse, setCompletedResponse] = useState<any>(null);

  useEffect(() => {
    let isMounted = true;

    async function makeRequest() {
      while (isMounted) {
        const response = await fetch('https://api.example.com/status');
        const data = await response.json();

        if (data.status === 'completed') {
          setCompletedResponse(data); // Set the completed response
          break;
        } else {
          await new Promise(resolve => setTimeout(resolve, 1000)); // Retry after 1 second
        }
      }
    }

    makeRequest();

    return () => {
      isMounted = false;
    };
  }, []);

  return completedResponse;
}

// Usage
function MyComponent() {
  const completedResponse = usePoolingRequest();

  // Render the completedResponse or handle loading state

  return (
    <div>
      {/* Render the completedResponse */}
      {completedResponse ? (
        <div>{JSON.stringify(completedResponse)}</div>
      ) : (
        <div>Loading...</div>
      )}
    </div>
  );
}
```
