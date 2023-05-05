import Foundation

public struct MapGetter<O: GetterOptic, MappedPart>: GetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = MappedPart
	
	public let optic: O
	@usableFromInline let update: (O.Part) -> MappedPart
	
	@inlinable
	public init(
		@GetterOpticBuilder _ build: () -> O,
		_ update: @escaping (O.Part) -> MappedPart
	) {
		self.optic = build()
		self.update = update
	}
	
	public func get(_ whole: Whole) -> Part {
		update(optic.get(whole))
	}
}

extension GetterOptic {
	public func map<MappedPart>(
		_ update: @escaping (Part) -> MappedPart
	) -> MapGetter<Self, MappedPart> {
		MapGetter({ self }, update)
	}
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapGetter<Self, MappedPart> {
		MapGetter({ self }, conversion.to)
	}
}
