# Throwing

## Protocol: ThrowingOptic

An optic that returns a value or throws an error. It might throw while getting, setting or updating the value.

## Combinators

### Throwing

Use it to create a throwing optic. You can use lenses, prisms, optional and throwing optics inside.

```
let optic = Throwing {
	Each {
		\Company.employees
	}
	\Person.name
}
```

## Conversions

You can convert other optics to a throwing one by using the function "throwing":

```
prism.throwing()
lens.throwing()
optional.throwing()
```

## Provided optics

### codableOptic

Any type that conforms to Codable has a codableOptic function that creates a ThrowingOptic:

```
let optic = User.codableOptic()
```

### fileOptic

This function on URL creates an optic that allows to read and modify the data of a file:

```
let optic = URL.fileOptic()
let data = try optic.get(fileUrl)
```
