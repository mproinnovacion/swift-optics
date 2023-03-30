import Foundation

public struct DropWhile<L: LensOptic, Element>: LensOptic
where L.Part == [Element], L.NewWhole == L.Whole, L.NewPart == L.Part {
	public typealias Whole = L.Whole
	public typealias Part = L.Part
	public typealias NewPart = L.Part
	public typealias NewWhole = L.Whole

	public let condition: (Element) -> Bool
	public let optic: L

	@inlinable
	public init(
		@LensBuilder with build: () -> L,
		while condition: @escaping (Element) -> Bool
	) {
		self.condition = condition
		self.optic = build()
	}

	public func get(_ whole: Whole) -> [Element] {
		Array(optic.get(whole).drop(while: condition))
	}

	public func update(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.update(whole) { elements in
			let toUpdate = Array(elements.drop(while: condition))
			let toKeep = elements.prefix(elements.count - toUpdate.count)
			
			let updated = f(toUpdate)
			return toKeep + updated
		}
	}
}

extension LensOptic {
	public func dropWhile<Element>(
		_ condition: @escaping (Element) -> Bool
	) -> DropWhile<Self, Element>
	where Part == [Element] {
		DropWhile {
			self
		} while: {
			condition($0)
		}
	}
}
