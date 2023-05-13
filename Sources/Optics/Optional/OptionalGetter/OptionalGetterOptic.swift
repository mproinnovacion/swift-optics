import Foundation

public protocol OptionalGetterOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
	
	func tryGet(_ whole: Whole) -> Part?
}

public struct OptionalGetterProvidedWholeOptic<O: OptionalGetterOptic>: OptionalGetterOptic {
	public typealias Whole = Void
	public typealias Part = O.Part
	
	public let optic: O
	public let whole: O.Whole
	
	public init(
		optic: O,
		whole: O.Whole
	) {
		self.optic = optic
		self.whole = whole
	}
	
	public func tryGet(_ whole: Void) -> O.Part? {
		optic.tryGet(self.whole)
	}
}

extension OptionalGetterOptic {
	public func provide(
		_ whole: Whole
	) -> OptionalGetterProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension OptionalGetterOptic where Whole == Void {
	public func tryGet() -> Part? {
		self.tryGet(())
	}
}
