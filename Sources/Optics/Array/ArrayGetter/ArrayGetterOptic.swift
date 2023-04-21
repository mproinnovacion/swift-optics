import Foundation

public protocol ArrayGetterOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
	
	func getAll(_ whole: Whole) -> [Part]
}

extension ArrayGetterOptic where Whole == Void {
	public func getAll() -> [Part] {
		self.getAll(())
	}
}
