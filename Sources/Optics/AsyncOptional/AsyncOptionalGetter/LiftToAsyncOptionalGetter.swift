import Foundation

public struct LiftOptionalGetterToAsync<O: OptionalGetterOptic>: AsyncOptionalGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func tryGet(_ whole: O.Whole) async -> O.Part? {
		self.optic.tryGet(whole)
	}
}
