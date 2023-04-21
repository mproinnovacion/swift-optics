import Foundation

public protocol GetterOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
	
	func `get`(_ whole: Whole) -> Part
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
