# Optional

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
