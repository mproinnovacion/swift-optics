import Foundation

public struct ArrayAt<O: ArrayOptic>: OptionalOptic
where O.NewPart == O.Part, O.NewWhole == O.Whole {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let index: Array.Index
	public let optic: O
	
	@inlinable
	public init(
		_ index: Array.Index,
		@ArrayOpticBuilder with build: () -> O
	) {
		self.index = index
		self.optic = build()
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		let results = optic.getAll(whole)
		
		guard results.count > self.index else {
			return nil
		}
		
		return results[self.index]
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		var current = 0
		return optic.updatingAll(in: whole) { element in
			defer { current += 1 }
			guard current == self.index else {
				return element
			}
			
			return f(element)
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

extension ArrayOptic {
	public func at(
		_ index: Int
	) -> ArrayAt<Self>
	where NewPart == Part, NewWhole == Whole {
		ArrayAt(index) {
			self
		}
	}
	
	public subscript(index: Int) -> ArrayAt<Self>
	where NewPart == Part, NewWhole == Whole {
		ArrayAt(index) {
			self
		}
	}
}
