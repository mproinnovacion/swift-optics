# swift-optics

🔬 An optics library for swift. More powerful than KeyPaths, optics allow to concat values from different places, modify many values at once, etc.

Status: Alpha. Feedback Needed.

---

* [Motivation](#Motivation)
* [Getting started](#Getting-started)
* [Documentation](#Documentation)
* [License](#License)

## Learn More

## Motivation

KeyPaths are provided by default by swift, but they can't be extended, you can't create them manually and they have several limitations. While KeyPaths work for structs, [swift-casepaths](https://github.com/pointfreeco/swift-case-paths "GitHub - pointfreeco/swift-case-paths: 🧰 Case paths bring the power and ergonomics of key paths to enums!") library (CasePath) provides an interface for enums. However, you can't combine a KeyPath and a CasePath, and there are things that can't be done by either.

## Getting Started

### Installation

Specify it as a dependency in your Package.swift:

```
.package(url: "https://bitbucket.org/damonfer/swift-optics.git", from: "0.1.0")
```

Check the documentation or the tests for a better understanding on how to use it, and all the utilities that come with it.

## Documentation

The documentation will be found in the "Documentation" folder.

## License

This library is released under the MIT license.

