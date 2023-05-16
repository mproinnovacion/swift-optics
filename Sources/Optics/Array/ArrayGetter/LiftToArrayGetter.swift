import Foundation

public struct LiftGetterToArray<O: GetterOptic>: ArrayGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func getAll(_ whole: O.Whole) -> [O.Part] {
		[self.optic.get(whole)]
	}
}

public struct LiftOptionalGetterToArray<O: OptionalGetterOptic>: ArrayGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func getAll(_ whole: O.Whole) -> [O.Part] {
		[self.optic.tryGet(whole)].compactMap { $0 }
	}
}
