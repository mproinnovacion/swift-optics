# Functions

##	Getters

A function *value* can be used as a getter. You can use a function value in any builder that defines a Getter, and it will be called when we need to get the result from the input parameter.

## Setters

A function *type* can be seen as a setter, where the Whole is the function itself, and the part is the result of the function. This can be used to map over function results. There are two cases here: having a function as the first item in the builder, or having a function as the Part of other optic.

### Function as the first Whole



### Function as a Part of another optic

If we have an optic that has a function as its part, we can use one of the utility operators to obtain a setter that will target the result of the function. Functions with up to 6 input parameters are supported. The utility functions are:

- **mapFunc**: For simple functions.
- **mapAsync**: For asynchronous functions.
- **mapThrows**: For throwing functions.
- **mapAsyncThrows**: For asynchronous throwing functions. 
