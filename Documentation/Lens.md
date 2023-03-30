# Lens

## Protocol: LensOptic

Protocol that represents a value that has a property that can be read and modified. A WritableKeyPath conforms to this protocol.

Functions:

```
get(Whole) -> Part
update(Whole, (Part) -> NewPart) -> NewWhole
set(Whole, NewPart) -> NewWhole
```

## Combinators.

### Lens

Use it to create a more complex lens from other lenses:

```
let lens = Lens {
	\Root.child
	\Child.value
}
```
