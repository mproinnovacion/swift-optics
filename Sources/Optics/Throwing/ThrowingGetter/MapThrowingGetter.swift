import Foundation

public struct MapThrowingGetter<O: ThrowingGetterOptic, MappedPart>: ThrowingGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = MappedPart
	
	public let optic: O
	@usableFromInline let update: (O.Part) -> MappedPart
	
	@inlinable
	public init(
		@ThrowingGetterOpticBuilder _ build: () -> O,
		_ update: @escaping (O.Part) -> MappedPart
	) {
		self.optic = build()
		self.update = update
	}
	
	public func get(_ whole: Whole) throws -> Part {
		let result = try optic.get(whole)
		return update(result)
	}
}

extension ThrowingGetterOptic {
	public func map<MappedPart>(
		_ update: @escaping (Part) -> MappedPart
	) -> MapThrowingGetter<Self, MappedPart> {
		MapThrowingGetter({ self }, update)
	}
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapThrowingGetter<Self, MappedPart> {
		MapThrowingGetter({ self }, conversion.to)
	}
}

