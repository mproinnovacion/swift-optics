import Foundation

public protocol ThrowingGetterOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
	
	func get(_ whole: Whole) throws -> Part
}

public struct ThrowingGetterProvidedWholeOptic<O: ThrowingGetterOptic>: ThrowingGetterOptic {
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
	public func get(_ whole: Void) throws -> O.Part {
		try optic.get(self.whole)
	}
}

extension ThrowingGetterOptic {
	public func provide(
		_ whole: Whole
	) -> ThrowingGetterProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension ThrowingGetterOptic where Whole == Void {
	public func get() throws -> Part {
		try self.get(())
	}
}
