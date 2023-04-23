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

extension GetterOptic where Whole == Void {
	public func get() -> Part {
		self.get(())
	}
}

extension KeyPath: GetterOptic {
	@inlinable
	public func get(_ whole: Root) -> Value {
		whole[keyPath: self]
	}
}
