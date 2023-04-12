# ThrowingArray

## Protocol: ThrowingArrayOptic

An optic that returns an array of values or throws an error. It might throw while getting, setting or updating the values.

## Combinators

### ManyThrowing

Use it to create a throwing array optic. You can use lenses, prisms, optional, array, throwing and throwing array optics inside.

```
let optic = ManyThrowing {
	Each {
		\Company.employees
	}
	\Person.name
}
```

## Conversions

You can convert an array optic to a throwing array optic by using the "throwing" function.

```
array.throwing()
```

