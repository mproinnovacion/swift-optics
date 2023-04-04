// swift-tools-version: 5.7
import PackageDescription

let package = Package(
	name: "swift-optics",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.tvOS(.v13),
		.watchOS(.v6),
	],
	products: [
		.library(
			name: "Optics",
			targets: ["Optics"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/pointfreeco/swift-case-paths", from: "0.14.0")
	],
	targets: [
		.target(
			name: "Optics",
			dependencies: [
				.product(name: "CasePaths", package: "swift-case-paths")
			]
		),
		.testTarget(
			name: "OpticsTests",
			dependencies: [
				"Optics",
				.product(name: "CasePaths", package: "swift-case-paths")
			]
		)
	]
)
