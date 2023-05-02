import Foundation

public protocol GetterOptic<Whole, Part> { //} : OptionalGetterOptic {
	associatedtype Whole
	associatedtype Part
	
	func `get`(_ whole: Whole) -> Part
}


extension GetterOptic {
	public func tryGet(_ whole: Whole) -> Part? {
		self.get(whole)
	}
}

extension KeyPath: GetterOptic {
	@inlinable
	public func get(_ whole: Root) -> Value {
		whole[keyPath: self]
	}
}

public struct GetterProvidedWholeOptic<O: GetterOptic>: GetterOptic {
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
	public func get(_ whole: Void) -> O.Part {
		optic.get(self.whole)
	}
}

extension GetterOptic {
	public func provide(
		_ whole: Whole
	) -> GetterProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension GetterOptic where Whole == Void {
	public func get() -> Part {
		self.get(())
	}
}
