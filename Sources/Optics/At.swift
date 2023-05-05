import Foundation

public struct At<L: LensOptic, Element>: OptionalOptic
where L.Part == [Element], L.NewPart == L.Part, L.NewWhole == L.Whole {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = Element
	public typealias NewPart = Element
	
	public let index: Array.Index
	public let lens: L
	
	@inlinable
	public init(
		_ index: Array.Index,
		@LensOpticBuilder with build: () -> L
	) {
		self.index = index
		self.lens = build()
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		let results = lens.get(whole)
		
		guard results.count > self.index else {
			return nil
		}
		
		return results[self.index]
	}
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.updating(whole) { elements in
			guard elements.count > self.index else {
				return elements
			}
			
			var result = elements
			result[self.index] = f(result[self.index])
			return result
		}
	}

	public func trySetting(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		tryUpdating(whole) { _ in
			newValue
		}
	}
}
