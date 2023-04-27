import Foundation

public struct LiftThrowingToThrowingArray<O: ThrowingOptic>: ThrowingArrayOptic
where O.NewPart == O.Part {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	@inlinable
	public func getAll(_ whole: Whole) throws -> [Part] {
		[try optic.get(whole)]
	}
	
	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try optic.updating(whole, f)
	}
}

public struct LiftArrayToThrowingArray<O: ArrayOptic>: ThrowingArrayOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	@inlinable
	public func getAll(_ whole: Whole) throws -> [Part] {
		optic.getAll(whole)
	}
	
	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try optic.updatingAll(whole) { part in
			try f(part)
		}
	}
}
