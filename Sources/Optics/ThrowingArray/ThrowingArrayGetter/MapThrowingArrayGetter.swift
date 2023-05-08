import Foundation

public struct MapThrowingArrayGetter<O: ThrowingArrayGetterOptic, MappedPart>: ThrowingArrayGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = MappedPart
	
	public let optic: O
	@usableFromInline let update: (O.Part) -> MappedPart
	
	@inlinable
	public init(
		@ThrowingArrayGetterOpticBuilder _ build: () -> O,
		_ update: @escaping (O.Part) -> MappedPart
	) {
		self.optic = build()
		self.update = update
	}
	
	public func getAll(_ whole: Whole) throws -> [Part] {
		let results = try optic.getAll(whole)
		return results.map(update)
	}
}

extension ThrowingArrayGetterOptic {
	public func map<MappedPart>(
		_ update: @escaping (Part) -> MappedPart
	) -> MapThrowingArrayGetter<Self, MappedPart> {
		MapThrowingArrayGetter({ self }, update)
	}
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapThrowingArrayGetter<Self, MappedPart> {
		MapThrowingArrayGetter({ self }, conversion.to)
	}
}
