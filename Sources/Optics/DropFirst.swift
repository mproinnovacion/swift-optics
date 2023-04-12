import Foundation

public struct DropFirst<L: LensOptic, Element>: LensOptic
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
			lens.get(whole).dropFirst(self.count)
		)
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try lens.updating(whole) { elements in
			var toUpdate = Array(elements.dropFirst(self.count))
			let notUpdated = elements.prefix(self.count)
			toUpdate = try f(toUpdate)
			return Array(notUpdated) + toUpdate
		}
	}
}

extension LensOptic {
	public func dropFirst<Element>(
		_ count: Int = 1
	) -> DropFirst<Self, Element>
	where Part == [Element] {
		DropFirst(count: count) {
			self
		}
	}
}
