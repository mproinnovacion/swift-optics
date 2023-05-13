import Foundation

public struct Min<L: LensOptic, Sorted: LensOptic, Element>: OptionalOptic
where L.Part == [Element], Sorted.Whole == Element, Sorted.Part: Comparable, L.NewPart == L.Part, L.NewWhole == L.Whole {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = Element
	public typealias NewPart = Part
	
	public let lens: L
	public let by: Sorted
	
	@inlinable
	public init(
		@LensOpticBuilder with build: () -> L,
		@LensOpticBuilder by: () -> Sorted
	) {
		self.lens = build()
		self.by = by()
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		lens.get(whole).min { left, right in
			self.by.get(left) < self.by.get(right)
		}
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.updating(in: whole) { elements in
			guard elements.count > 0 else {
				return elements
			}

			let indexedMax = zip(0..., elements).min { left, right in
				self.by.get(left.1) < self.by.get(right.1)
			}
			
			guard let index = indexedMax?.0 else {
				return elements
			}
			
			var result = elements
			result[index] = f(result[index])
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
