import Foundation

public protocol OptionalGetterOptic<Whole, Part> { // }: ArrayGetterOptic {
	associatedtype Whole
	associatedtype Part
	
	func tryGet(_ whole: Whole) -> Part?
}

extension OptionalGetterOptic where Whole == Void {
	public func tryGet() -> Part? {
		self.tryGet(())
	}
}

extension OptionalGetterOptic {
	public func getAll(_ whole: Whole) -> [Part] {
		[self.tryGet(whole)].compactMap { $0 }
	}
}
