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
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.updating(in: whole) { elements in
			guard elements.count > self.index else {
				return elements
			}
			
			var result = elements
			result[self.index] = f(result[self.index])
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

extension LensOptic {
	public func at<Element>(_ index: Int) -> At<Self, Element>
	where Part == [Element], NewPart == Part, NewWhole == Whole {
		At(index) {
			self
		}
	}
	
	public subscript<Element>(_ index: Int) -> At<Self, Element>
	where Part == [Element], NewPart == Part, NewWhole == Whole {
		At(index) {
			self
		}
	}
}
