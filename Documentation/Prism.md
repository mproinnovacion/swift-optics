# Prism

## Protocol: PrismOptic

Protocol that represents a case of an enum, such that it can be extracted and embedded. A CasePath conforms to this protocol.

Functions:

```
extract(Whole) -> Part?
embed(Part) -> Whole
```

## Combinators

### Prism

Use it to create a prism from one or more prisms:

```
Prism {
	/Failable<Person>?.some
	/Failable<Person>.valid
}
```
