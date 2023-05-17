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

## RawRepresentable

A RawRepresentable can be seen as an inverse Prism, where the Whole is the RawValue, and the Part is the RawRepresentable. This is due to the fact that the RawValue is usually a bigger type, and so we can always embed a RawValue into a RawRepresentable, but we can't always extract a RawRepresentable from its RawValue:

```
enum MyEnum: Int {
	case one = 1
}

MyEnum.prismOptic().embed(.one) // Returns 1
MyEnum.prismOptic().extract(3) // Returns nil

```

## Array

### singleOptic

This optic allows to treat the array as a collection of a single element. If you embed a new element the resulting array will only contain it. If you extract from it only the first element will be retrieved.

### firstElementOptic

This prism targets the first element of the array. It returns a tuple, with the first element in the left side and the rest on the right side.

### lastElementOptic

This prism targets the last element of the array. It returns a tuple, with the last element in the right side and the rest on the left side.
