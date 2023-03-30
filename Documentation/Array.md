# Array

## Protocol: ArrayOptic

Protocol that represents a property with many values that can be read into an array or updated one by one.

Functions:

```
getAll(Whole) -> [Part]
updateAll(Whole, (Part) -> NewPart) -> NewWhole
```

## Combinators

### Many

Use it to create a more complex optic from lenses, prisms, optionals and array optics:

```
let optic = Many {
	Each {
		\Company.employees
	}
	\Person.name
}
```

### Each

Use it to convert a LensOptic of an array into an ArrayOptic.

```
let optic = Each {
	\Company.employees
}
```

It is however recommended that you use the function:

```
Lens {
	\Company.employees
}.each()
```

### EachOptional

Converts an OptionalOptic of an array into an ArrayOptic.

```
let optic = EachOptional {
	\Company.advisor
}
```

It is however recommended that you use the function:

```
Lens {
	\Company.employees
}.each()
```

### Concat

Concats multiple ArrayOptics where all the types match into a single ArrayOptic. For example:

```
let people = Concat {
	Each {
		\Company.employees
	}
	Each {
		\Company.freelance
	}
}
```

This will combine all the company employees and freelance into a single array.
