import Foundation

public struct First<L: LensOptic, Element>: OptionalOptic where L.Part == [Element], L.NewPart == L.Part, L.NewWhole == L.Whole {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = Element
	public typealias NewPart = Element
	
	public let lens: L
	
	@inlinable
	public init(
		@LensOpticBuilder with build: () -> L
	) {
		self.lens = build()
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		lens.get(whole).first
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.updating(in: whole) { elements in
			guard elements.count > 0 else {
				return elements
			}
			
			var result = elements
			result[0] = f(result[0])
			return result
		}
	}

	public func trySetting(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		tryUpdating(in: whole) { _ in
			newValue
		}
	}
}
