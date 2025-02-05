import Foundation

public struct TakeFirst<L: LensOptic, Element>: LensOptic
where L.Part == [Element], L.NewWhole == L.Whole, L.NewPart == L.Part {
	public typealias Whole = L.Whole
	public typealias Part = L.Part
	public typealias NewPart = L.Part
	public typealias NewWhole = L.Whole
	
	public var count: Int
	public var lens: L
	
	@inlinable
	public init(
		count: Int = 1,
		@LensOpticBuilder with build: () -> L
	) {
		self.count = count
		self.lens = build()
	}
	
	public func get(_ whole: Whole) -> Part {
		Array(
			lens.get(whole).prefix(self.count)
		)
	}
	
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.updating(in: whole) { elements in
			let toKeep = Array(elements.dropFirst(self.count))
			var toUpdate = Array(elements.prefix(self.count))
			toUpdate = f(toUpdate)
			return toUpdate + Array(toKeep)
		}
	}
}

extension LensOptic {
	public func takeFirst<Element>(
		_ count: Int = 1
	) -> TakeFirst<Self, Element>
	where Part == [Element] {
		TakeFirst(count: count) {
			self
		}
	}
}
