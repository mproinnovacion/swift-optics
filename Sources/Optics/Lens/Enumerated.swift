import Foundation

public struct Enumerated<L: LensOptic, Element, NewElement>: LensOptic
where L.Part == [Element], L.NewPart == [NewElement] {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = [(Array.Index, Element)]
	public typealias NewPart = [(Array.Index, NewElement)]
	
	public let lens: EnumeratedLensOptic<L, Element, NewElement>
	
	@inlinable
	public init(
		@LensOpticBuilder with build: () -> L
	) {
		self.lens = EnumeratedLensOptic(lens: build())
	}
	
	public func get(_ whole: Whole) -> Part {
		lens.get(whole)
	}
	
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.updating(in: whole, update: f)
	}
}

public struct EnumeratedLensOptic<L: LensOptic, Element, NewElement>: LensOptic
where L.Part == [Element], L.NewPart == [NewElement] {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = [(Array.Index, Element)]
	public typealias NewPart = [(Array.Index, NewElement)]
	
	public let lens: L
	
	public init(lens: L) {
		self.lens = lens
	}
	
	public func get(_ whole: L.Whole) -> [(Array.Index, Element)] {
		lens.get(whole).enumerated().map { ($0.offset, $0.element) }
	}
	
	public func updating(
		in whole: L.Whole,
		update f: @escaping ([(Array.Index, Element)]) -> [(Array.Index, NewElement)]
	) -> L.NewWhole {
		lens.updating(in: whole) { array in
			f(
				array.enumerated().map { ($0.offset, $0.element) }
			).map {$0.1 }
		}
	}
}
