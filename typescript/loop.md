# Loop

## Array
```ts
const numbers: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

// loop pattern 1 (high performance)
for (let index = 0; index < numbers.length; index++) {
  console.log(`index: ${index}, value: ${numbers[index]}`);
}
// loop pattern 2 (get only value)
for (const value of numbers) {
  console.log(`value: ${value}`);
}
// loop pattern 3 (loop can not be stopped in the middle)
numbers.forEach((value, index) => {
  console.log(`index: ${index}, value: ${value}`);
});
// loop pattern 4 (target must be es2015 or higher)
for (const [index, value] of numbers.entries()) {
  console.log(`index: ${index}, value: ${value}`);
}
// loop pattern 5 using map, downside is slower
numbers.map((value, index) => {
  console.log(`index: ${index}, value: ${value}`);
});
// loop pattern 6 downside is random order
for (const index in numbers) {
  // index type is string
  console.log(`index: ${index}, value: ${numbers[index]}`);
}
```

## Array of Object
```ts
const months: Month[] = [
  { month: 'Jan', days: 31 },
  { month: 'Feb', days: 28 },
  { month: 'Mar', days: 31 },
  { month: 'Apr', days: 30 },
  { month: 'May', days: 31 },
  { month: 'Jun', days: 30 },
  { month: 'Jul', days: 31 },
];

months.forEach((monthData) => {
  const { month, days } = monthData;
  console.log(`${month} has ${days} days.`);
});

for (const monthData of months) {
  const { month, days } = monthData;
  console.log(`${month} has ${days} days.`);
}
```

## Key Value
```ts
interface Months {
  [month: string]: number;
}
const months: Months = {
  Jan: 31,
  Feb: 28,
  Mar: 31,
  Apr: 30,
};

// loop pattern 1
Object.entries(months).forEach(([month, days]) => {
  console.log(`${month} has ${days} days.`);
});

// loop pattern 2
for (const month in months) {
  const days = months[month];
  console.log(`${month} has ${days} days.`);
}
```

## Map Value
```ts
const months = new Map<string, number>([
  ['Jan', 31],
  ['Feb', 28],
  ['Mar', 31],
  ['Apr', 30],
]);
for (const [month, days] of months) {
  console.log(`${month} has ${days} days.`);
}
months.forEach((days, month) => {
  console.log(`${month} has ${days} days.`);
});
```
