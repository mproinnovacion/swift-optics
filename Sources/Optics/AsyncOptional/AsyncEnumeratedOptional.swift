import Foundation

public struct AsyncEnumeratedOptionally<O: AsyncOptionalOptic, Element, NewElement>: AsyncOptionalOptic
where O.Part == [Element], O.NewPart == [NewElement] {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = [(Array.Index, Element)]
	public typealias NewPart = [(Array.Index, NewElement)]
	
	public let optic: EnumeratedAsyncOptionalOptic<O, Element, NewElement>
	
	@inlinable
	public init(
		@AsyncOptionalOpticBuilder with build: () -> O
	) {
		self.optic = EnumeratedAsyncOptionalOptic(optic: build())
	}
	
	public func tryGet(_ whole: Whole) async -> Part? {
		await optic.tryGet(whole)
	}
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await optic.tryUpdating(whole, f)
	}
	
	public func trySetting(_ whole: Whole, to newPart: NewPart) async -> NewWhole {
		await optic.trySetting(whole, to: newPart)
	}
}

public struct EnumeratedAsyncOptionalOptic<O: AsyncOptionalOptic, Element, NewElement>: AsyncOptionalOptic
where O.Part == [Element], O.NewPart == [NewElement] {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = [(Array.Index, Element)]
	public typealias NewPart = [(Array.Index, NewElement)]
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func tryGet(_ whole: Whole) async -> Part? {
		await optic.tryGet(whole)?.enumerated().map { ($0.offset, $0.element) }
	}
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await optic.tryUpdating(whole) { array in
			try await f(
				array.enumerated().map { ($0.offset, $0.element) }
			).map { $0.1 }
		}
	}
	
	public func trySetting(_ whole: Whole, to newPart: NewPart) async -> NewWhole {
		await optic.trySetting(whole, to: newPart.map { $0.1 })
	}
}
