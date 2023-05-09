# Optional

Targets zero or one value, allowing to update them one by one and retrieve all of them in an array. This is a traversal1 or affine traversal in the traditional literature.

## Protocol: OptionalOptic

Protocol that represents a property that can be optionally read and modified. We might not be able to read it, and we also might not be able to modify it.

Functions:

```
tryGet(Whole) -> Part?
tryUpdate(Whole, (Part) -> NewPart) -> NewWhole
trySet(Whole, NewPart) -> NewWhole
```

## Combinators

### Optionally

Use it to create a more complex optic from lenses, prisms and optional optics:

```
let optic = Optionally {
	\Company.advisor
	Prism {
		/Failable<Person>?.some
		/Failable<Person>.valid
	}
}
```

### First

Produces an OptionalOptic from a LensOptic of an Array by selecting the first element.

```
let firstEmployee = First {
	Lens {
		\Company.employees
	}
}
```

### Last

Produces an OptionalOptic from a LensOptic of an Array by selecting the last element.

```
let lastEmployee = Last {
	Lens {
		\Company.employees
	}
}
```
