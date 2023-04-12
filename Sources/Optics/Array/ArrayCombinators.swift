import Foundation

/// Main ArrayOptic builder.
public struct Many<Optics: ArrayOptic>: ArrayOptic {
	public typealias Whole = Optics.Whole
	public typealias NewWhole = Optics.NewWhole
	public typealias Part = Optics.Part
	public typealias NewPart = Optics.NewPart
	
	public let optics: Optics
	
	@inlinable
	public init(
		@ArrayOpticBuilder with build: () -> Optics
	) {
		self.optics = build()
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optics.getAll(whole)
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try optics.updatingAll(whole, f)
	}
}


//public struct Reversed<Optics: ArrayOptic>: ArrayOptic {
//	public typealias Whole = Optics.Whole
//	public typealias Part = Optics.Part
//
//	public let optics: Optics
//
//	@inlinable
//	public init(
//		@ArrayOpticBuilder with build: () -> Optics
//	) {
//		self.optics = build()
//
//	}
//
//	public func getAll(_ whole: Whole) -> [Part] {
//		optics.getAll(whole).reversed()
//	}
//	
//	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		optics.updateAll(&whole, f)
//	}
//}
