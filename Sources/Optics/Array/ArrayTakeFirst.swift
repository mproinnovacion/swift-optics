import Foundation

public struct ArrayTakeFirst<O: ArrayOptic>: ArrayOptic
where O.NewWhole == O.Whole, O.NewPart == O.Part {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	public typealias NewPart = O.Part
	public typealias NewWhole = O.Whole
	
	public var count: Int
	public var optic: O
	
	@inlinable
	public init(
		count: Int = 1,
		@ArrayOpticBuilder with build: () -> O
	) {
		self.count = count
		self.optic = build()
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		Array(
			optic.getAll(whole).prefix(self.count)
		)
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		var updated = 0
		
		return optic.updatingAll(in: whole) { element in
			defer { updated += 1}
			guard updated <= count else {
				return element
			}
			
			return f(element)
		}
	}
}

extension ArrayOptic {
	public func takeFirst(
		_ count: Int = 1
	) -> ArrayTakeFirst<Self>
	where NewWhole == Whole, NewPart == Part {
		ArrayTakeFirst(count: count) {
			self
		}
	}
}
