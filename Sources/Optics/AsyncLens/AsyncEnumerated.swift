import Foundation

public struct AsyncEnumerated<L: AsyncLensOptic, Element, NewElement>: AsyncLensOptic
where L.Part == [Element], L.NewPart == [NewElement] {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = [(Array.Index, Element)]
	public typealias NewPart = [(Array.Index, NewElement)]
	
	public let lens: AsyncEnumeratedLensOptic<L, Element, NewElement>
	
	@inlinable
	public init(
		@AsyncLensOpticBuilder with build: () -> L
	) {
		self.lens = AsyncEnumeratedLensOptic(lens: build())
	}
	
	public func get(_ whole: Whole) async -> Part {
		await lens.get(whole)
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await lens.updating(whole, f)
	}
}

public struct AsyncEnumeratedLensOptic<L: AsyncLensOptic, Element, NewElement>: AsyncLensOptic
where L.Part == [Element], L.NewPart == [NewElement] {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = [(Array.Index, Element)]
	public typealias NewPart = [(Array.Index, NewElement)]
	
	public let lens: L
	
	public init(lens: L) {
		self.lens = lens
	}
	
	public func get(_ whole: L.Whole) async -> [(Array.Index, Element)] {
		await lens.get(whole).enumerated().map { ($0.offset, $0.element) }
	}
	
	public func updating(
		_ whole: L.Whole,
		_ f: @escaping ([(Array.Index, Element)]) async throws -> [(Array.Index, NewElement)]
	) async rethrows -> L.NewWhole {
		try await lens.updating(whole) { array in
			try await f(
				array.enumerated().map { ($0.offset, $0.element) }
			).map {$0.1 }
		}
	}
}
