import Foundation

public protocol ThrowingGetterOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
	
	func get(_ whole: Whole) throws -> Part}

extension ThrowingGetterOptic where Whole == Void {
	func get() throws -> Part {
		try self.get(())
	}
}
