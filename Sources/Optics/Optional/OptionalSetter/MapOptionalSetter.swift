import Foundation

public struct MapOptionalSetter<O: OptionalSetterOptic, MappedPart, MappedNewPart>: OptionalSetterOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = MappedPart
	public typealias NewPart = MappedNewPart
	
	public let optic: O
	@usableFromInline let from: (O.Part) -> MappedPart
	@usableFromInline let to: (O.Part, MappedNewPart) -> O.NewPart

	public init(
		optic: O,
		from: @escaping (O.Part) -> MappedPart,
		to: @escaping (O.Part, MappedNewPart) -> O.NewPart

	) {
		self.optic = optic
		self.from = from
		self.to = to
	}
	
	public func tryUpdating(
		_ whole: O.Whole,
		_ f: @escaping (MappedPart) -> MappedNewPart
	) -> O.NewWhole {
		self.optic.tryUpdating(whole) { part in
			to(part, f(from(part)))
		}
	}
}
