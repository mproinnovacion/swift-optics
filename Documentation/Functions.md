# Functions

##	Getters

A function *value* can be used as a getter. You can use a function value in any builder that defines a Getter, and it will be called when we need to get the result from the input parameter.

## Setters

A function *type* can be seen as a setter, where the Whole is the function itself, and the part is the result of the function. This can be used to map over function results.

The library also provides utility functions over setters to map over function outputs where the setter has a function as its part: map, mapAsync.
