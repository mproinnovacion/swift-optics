import Foundation

public struct ArrayDropWhile<O: ArrayOptic>: ArrayOptic
where O.NewWhole == O.Whole, O.NewPart == O.Part {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	public typealias NewPart = O.Part
	public typealias NewWhole = O.Whole

	public let condition: (Part) -> Bool
	public let optic: O

	@inlinable
	public init(
		@ArrayOpticBuilder with build: () -> O,
		while condition: @escaping (Part) -> Bool
	) {
		self.condition = condition
		self.optic = build()
	}

	public func getAll(_ whole: Whole) -> [Part] {
		Array(optic.getAll(whole).drop(while: condition))
	}

	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		var dropping = true
		
		return optic.updatingAll(in: whole) { element in
			guard dropping, condition(element) else {
				dropping = false
				return f(element)
			}
			
			return element
		}
	}
}

extension ArrayOptic {
	public func dropWhile(
		_ condition: @escaping (Part) -> Bool
	) -> ArrayDropWhile<Self>
	where NewWhole == Whole, NewPart == Part {
		ArrayDropWhile {
			self
		} while: {
			condition($0)
		}
	}
}
