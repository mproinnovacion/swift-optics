import Foundation

public protocol AsyncGetterOptic<Whole, Part> { //} : OptionalGetterOptic {
	associatedtype Whole
	associatedtype Part
	
	func `get`(_ whole: Whole) async -> Part
}

extension AsyncGetterOptic where Whole == Void {
	public func get() async -> Part {
		await self.get(())
	}
}
