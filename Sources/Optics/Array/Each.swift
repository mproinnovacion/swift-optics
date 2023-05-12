import Foundation

/// Transforms a Lens of an Array to an ArrayOptic
public struct Each<L: LensOptic, Element, NewElement>: ArrayOptic
where L.Part == [Element], L.NewPart == [NewElement] {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = Element
	public typealias NewPart = NewElement
	
	public let optic: L
	
	@inlinable
	public init(
		@LensOpticBuilder with build: () -> L
	) {
		self.optic = build()
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optic.get(whole)
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updating(in: whole) { parts in
			parts.map(f)
		}
	}
}
