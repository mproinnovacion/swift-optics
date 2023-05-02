import Foundation

public struct EnumeratedOptionally<O: OptionalOptic, Element, NewElement>: OptionalOptic
where O.Part == [Element], O.NewPart == [NewElement] {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = [(Array.Index, Element)]
	public typealias NewPart = [(Array.Index, NewElement)]
	
	public let optic: EnumeratedOptionalOptic<O, Element, NewElement>
	
	@inlinable
	public init(
		@OptionalOpticBuilder with build: () -> O
	) {
		self.optic = EnumeratedOptionalOptic(optic: build())
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		optic.tryGet(whole)
	}
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdating(whole, f)
	}
	
	public func trySetting(_ whole: Whole, to newPart: NewPart) -> NewWhole {
		optic.trySetting(whole, to: newPart)
	}
}

public struct EnumeratedOptionalOptic<O: OptionalOptic, Element, NewElement>: OptionalOptic
where O.Part == [Element], O.NewPart == [NewElement] {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = [(Array.Index, Element)]
	public typealias NewPart = [(Array.Index, NewElement)]
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		optic.tryGet(whole)?.enumerated().map { ($0.offset, $0.element) }
	}
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdating(whole) { array in
			f(
				array.enumerated().map { ($0.offset, $0.element) }
			).map { $0.1 }
		}
	}
	
	public func trySetting(_ whole: Whole, to newPart: NewPart) -> NewWhole {
		optic.trySetting(whole, to: newPart.map { $0.1 })
	}
}
