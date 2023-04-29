import Foundation

public protocol AsyncOptionalGetterOptic<Whole, Part> { // }: ArrayGetterOptic {
	associatedtype Whole
	associatedtype Part
	
	func tryGet(_ whole: Whole) async -> Part?
}

extension AsyncOptionalGetterOptic where Whole == Void {
	public func tryGet() async -> Part? {
		await self.tryGet(())
	}
}
