# Provided Optics

## KeyPath

KeyPath conforms to LensOptic.

## CasePath

CasePath conforms to PrismOptic.

## Dictionary

### valuesOptic

An ArrayOptic of the dictionary values.

## Array

### optic

An ArrayOptic of its elements.

## Set

### optic

An ArrayOptic of its elements.

## Optional

### optic

A **PrismOptic** for the "some" case.

## Result

### optic

A PrismOptic for the "success" case.

## RawRepresentable

### rawValueOptic

An OptionalOptic that allows to access the rawValue.
 
### prismOptic

A PrismOptic that might be reversed from what is expected. The Part is actually the RawRepresentable, while the Whole is the RawValue. This is because the RawRepresentable is actually "smaller" than the RawValue, and as such it's not always possible to get a RawRepresentable from a RawValue, but the opposite is always true.

```
enum Number: Int, RawRepresentable {
	case one = 1
	case two = 2
	case three = 3
}

Number.prismOptic().extract(from: 1) // Returns Number.one
Number.prismOptic().extract(from: 7) // Returns nil

```

## URL

### componentsOptic

An OptionalOptic to convert between a URL and its URLComponents.

### schemeOptic

An OptionalOptic to access the scheme of a URL.

### hostOptic

An OptionalOptic to access the host of a URL.

### userOptic

An OptionalOptic to access the user of a URL.

### passwordOptic

An OptionalOptic to access the password of a URL.

### portOptic

An OptionalOptic to access the port of a URL.

### pathOptic

An OptionalOptic to access the path of a URL as a String.

### queryOptic

An OptionalOptic to access the query of a URL as a String.

### fragmentOptic

An OptionalOptic to access the fragment of a URL.

### queryItemsOptic

An OptionalOptic to access the queryItems of a URL as [URLQueryItem].

### absoluteStringOptic

An OptionalOptic to convert between a URL and its absoluteString representation.

### fileOptic

A ThrowingOptic that allows to access the file contents as Data.

## Codable

### codableOptic

A ThrowingOptic that allows to convert between Data and the Type.

## Date

### componentsOptic

An OptionalOptic to access the DateComponents.

### componentOptic

Function to get an OptionalOptic to access the specified component of the Date.

### dayOptic

An OptionalOptic for the day.

### weekdayValueOptic

An OptionalOptic for the weekday as a number.

### weekdayOptic

An OptionalOptic for the weekday; represented as an enum.

### monthOptic

An OptionalOptic for the month.

### yearOptic

An OptionalOptic for the year.

### hourOptic

An OptionalOptic for the hours.

### minuteOptic

An OptionalOptic for the minutes.

### secondOptic

An OptionalOptic for the seconds.
