// swift-tools-version: 5.9
import PackageDescription
import CompilerPluginSupport

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
		.package(url: "https://github.com/pointfreeco/swift-case-paths", from: "0.14.0"),
		.package(url: "https://bitbucket.org/damonfer/swift-algebra", from: "0.1.0"),
		.package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0-swift-5.9-DEVELOPMENT-SNAPSHOT-2023-04-25-b")
	],
	targets: [
		.macro(
			 name: "OpticsMacros",
			 dependencies: [
				  .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
				  .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
			 ]
		),
		.target(
			name: "Optics",
			dependencies: [
				.product(name: "CasePaths", package: "swift-case-paths"),
				.product(name: "Algebra", package: "swift-algebra"),
				"OpticsMacros"
			]
		),
		.testTarget(
			name: "OpticsTests",
			dependencies: [
				"Optics",
				.product(name: "CasePaths", package: "swift-case-paths"),
				"OpticsMacros",
				.product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
			],
			resources: [
				.copy("model.json")
			]
		)
	]
)
