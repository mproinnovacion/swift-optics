# swift-optics

🔬 An optics library for swift. More powerful than KeyPaths, optics allow to concat values from different places, modify many values at once, etc.

Status: Alpha. Feedback Needed.

---

* [Introduction](#Introduction)
* [Motivation](#Motivation)
* [Getting started](#Getting-started)
* [Documentation](#Documentation)
* [License](#License)

## Learn More

## Introduction

You can think of optics as queries for your own models. You can use them to read or modify many values across different properties in any place of a structure. Optics are also composable, which means you can easily extract some components of an optic to use them in many places. 

Types of optics:

- **Lens**. A generalization of a WritableKeyPath. Targets a single value, which can always be read and modified. Beware that an array can be understood as a single value, where we read the whole array and modify it as a whole.
	- get
	- updating
- **Prism**. A generalization of a CasePath. Targets an associated value in an enum. You can try to *extract* it, which returns an optional, and *embed* it, which always returns the Whole.
	- embed
	- extract
- **Optional**. Targets one value that might or might not exist. You can try reading or modifying it, but there are no guarantees that it will work.
	- tryGet
	- tryUpdating
- **Array**. Targets many values. Reading from it will return an array of values, while the update operation allows you to modify the values one by one.
	- getAll
	- updateAll
- **Throwing**. Targets a single value. Reading or modifying it might throw an error.
	- get (throws)
	- updating (throws)
- **ThrowingArray**. Targets many values. Reading or modifying it might throw an error.
	- getAll (throws)
	- updatingAll (throws)
	
## Goals

The goals of this library mimic the goals of the [swift programming language](https://www.swift.org/about):

- **Safe**. Optics should be safe to use, and optics that might fail should indicate so by returning an optional or throwing.
- **Expressive**. Optics should be easy to write and easy to read, and composable so they can be reused in many ways. Just as in the swift programming language, brevity is a non-goal, and clarity and legibity should always take precedence.
- **Swiftness**. The library should feel native to the swift language, using familiar concepts and a syntax.

## Motivation

KeyPaths are provided by default by swift, but they can't be extended, you can't create them manually and they have several limitations. While KeyPaths work for structs, [swift-casepaths](https://github.com/pointfreeco/swift-case-paths "GitHub - pointfreeco/swift-case-paths: 🧰 Case paths bring the power and ergonomics of key paths to enums!") library (CasePath) provides an interface for enums. However, you can't combine a KeyPath and a CasePath, and there are things that can't be done by either.

The driving idea behind the library is to provide with powerful tools to target single or many parts of a whole, while being expressive and easy to use.

## Getting Started

### Installation

Specify it as a dependency in your Package.swift:

```
.package(url: "https://bitbucket.org/damonfer/swift-optics.git", from: "0.1.8")
```

Check the documentation or the tests for a better understanding on how to use it, and all the utilities that come with it.

## Documentation

The documentation will be found in the "Documentation" folder.

## License

This library is released under the MIT license.

