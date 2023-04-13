import Foundation

public struct EnumeratedPrism<O: PrismOptic, Element>: PrismOptic
where O.Part == [Element] {
	public typealias Whole = O.Whole
	public typealias Part = [(Array.Index, Element)]
	
	public let optic: EnumeratedPrismOptic<O, Element>
	
	@inlinable
	public init(
		@PrismOpticBuilder with build: () -> O
	) {
		self.optic = EnumeratedPrismOptic(optic: build())
	}
	
	public func extract(from whole: Whole) -> Part? {
		optic.extract(from: whole)
	}
	
	public func embed(_ part: Part) -> Whole {
		optic.embed(part)
	}
}

public struct EnumeratedPrismOptic<O: PrismOptic, Element>: PrismOptic
where O.Part == [Element] {
	public typealias Whole = O.Whole
	public typealias Part = [(Array.Index, Element)]
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func extract(from whole: O.Whole) -> [(Int, Element)]? {
		optic.extract(from: whole)?.enumerated().map { ($0.offset, $0.element)
		}
	}
	
	public func embed(_ part: [(Int, Element)]) -> O.Whole {
		optic.embed(part.map { $0.1 })
	}
}
