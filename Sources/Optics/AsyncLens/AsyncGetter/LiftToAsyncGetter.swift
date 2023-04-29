import Foundation

public struct LiftGetterToAsync<O: GetterOptic>: AsyncGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	let optic: O
	
	public init(
		optic: O
	) {
		self.optic = optic
	}
	
	public func get(_ whole: O.Whole) async -> O.Part {
		optic.get(whole)
	}
}

extension GetterOptic {
	public func async() -> LiftGetterToAsync<Self> {
		.init(optic: self)
	}
}
