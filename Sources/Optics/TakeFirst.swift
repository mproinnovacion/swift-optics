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
		@LensBuilder with build: () -> L
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
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try lens.updating(whole) { elements in
			let toKeep = Array(elements.dropFirst(self.count))
			var toUpdate = Array(elements.prefix(self.count))
			toUpdate = try f(toUpdate)
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
