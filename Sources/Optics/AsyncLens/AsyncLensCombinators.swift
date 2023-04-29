import Foundation

public struct AsyncLens<L: AsyncLensOptic>: AsyncLensOptic {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = L.Part
	public typealias NewPart = L.NewPart
	
	public let lens: L
	
	@inlinable
	public init(
		@AsyncLensOpticBuilder with build: () -> L
	) {
		self.lens = build()
	}
	
	public func get(_ whole: L.Whole) async -> L.Part {
		await lens.get(whole)
	}
	
	public func updating(
		_ whole: L.Whole,
		_ f: @escaping (L.Part) async throws -> L.NewPart
	) async rethrows -> L.NewWhole {
		try await lens.updating(whole, f)
	}
}
