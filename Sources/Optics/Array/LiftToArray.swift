import Foundation

public struct LiftLensToArray<O: LensOptic>: ArrayOptic {
	let lens: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public func getAll(_ whole: Whole) -> [Part] {
		[lens.get(whole)]
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try lens.updating(whole, f)
	}
}

public struct LiftOptionalToArray<O: OptionalOptic>: ArrayOptic {
	let optic: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public func getAll(_ whole: Whole) -> [Part] {
		[optic.tryGet(whole)].compactMap { $0 }
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try optic.tryUpdating(whole, f)
	}
}
