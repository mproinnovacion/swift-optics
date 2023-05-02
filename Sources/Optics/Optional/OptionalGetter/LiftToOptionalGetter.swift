import Foundation

public struct LiftGetterToOptional<O: GetterOptic>: OptionalGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func tryGet(_ whole: O.Whole) -> O.Part? {
		self.optic.get(whole)
	}
}
