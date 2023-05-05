import Foundation

/// Transforms a Lens of an Array to an ArrayOptic
public struct Each<L: LensOptic, Element, NewElement>: ArrayOptic
where L.Part == [Element], L.NewPart == [NewElement] {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = Element
	public typealias NewPart = NewElement
	
	public let lens: L
	
	@inlinable
	public init(
		@LensOpticBuilder with build: () -> L
	) {
		self.lens = build()
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		lens.get(whole)
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.updating(whole) { parts in
			parts.map(f)
		}
	}
}
