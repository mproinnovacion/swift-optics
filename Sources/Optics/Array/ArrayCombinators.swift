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
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optics.updatingAll(in: whole, update: f)
	}
}
