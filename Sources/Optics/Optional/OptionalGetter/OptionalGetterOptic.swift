import Foundation

public protocol OptionalGetterOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
	
	func tryGet(_ whole: Whole) -> Part?
}

extension OptionalGetterOptic where Whole == Void {
	public func tryGet() -> Part? {
		self.tryGet(())
	}
}
