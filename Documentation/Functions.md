# Functions

##	Getters

A function *value* can be used as a getter. You can use a function value in any builder that defines a Getter, and it will be called when we need to get the result from the input parameter.

## Setters

A function *type* can be seen as a setter, where the Whole is the function itself, and the part is the result of the function. This can be used to map over function results. There are two cases here: having a function as the first item in the builder, or having a function as the Part of other optic.

### Function as the first Whole

There seems to be a bug in the swift compiler that prevents async functions to be treated in generic parameters. The workaround for this wraps the function in a struct, storing it into a property *run*. This way, if you need to modify a function in a variable, you will need to use the run property to assign it:

```
func f() async -> Int {
	5
}

var myFunc = Setter {
	f
}.updating { number in
	number * 2
}.run
```

See tests like testFunc0InVariable for more examples.

### Function as a Part of another optic

If we have an optic that has a function as its part, we can use one of the utility operators to obtain a setter that will target the result of the function. Functions with up to 6 input parameters are supported. The utility functions are:

- **mapFunc**: For simple functions.
- **mapAsync**: For asynchronous functions.
- **mapThrows**: For throwing functions.
- **mapAsyncThrows**: For asynchronous throwing functions. 
