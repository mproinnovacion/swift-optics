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
	
	public func update(_ whole: L.Whole, _ f: @escaping (L.Part) -> L.NewPart) -> L.NewWhole {
		lens.update(whole, f)
	}
}
