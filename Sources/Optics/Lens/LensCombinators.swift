import Foundation

public struct Lens<L: LensOptic>: LensOptic {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = L.Part
	public typealias NewPart = L.NewPart
	
	public let lens: L
	
	@inlinable
	public init(
		@LensBuilder with build: () -> L
	) {
		self.lens = build()
	}
	
	public func get(_ whole: L.Whole) -> L.Part {
		lens.get(whole)
	}
	
	public func updating(
		_ whole: L.Whole,
		_ f: @escaping (L.Part) throws -> L.NewPart
	) rethrows -> L.NewWhole {
		try lens.updating(whole, f)
	}
}
