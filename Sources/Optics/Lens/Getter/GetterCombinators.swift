import Foundation

public struct Getter<O: GetterOptic>: GetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	@inlinable
	public init(
		@GetterOpticBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func get(_ whole: O.Whole) -> O.Part {
		self.optic.get(whole)
	}
}

public struct Not<O: GetterOptic>: GetterOptic where O.Part == Bool {
	public typealias Whole = O.Whole
	public typealias Part = Bool
	
	public let optic: O
	
	@inlinable
	public init(
		@GetterOpticBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func get(
		_ whole: Whole
	) -> Part {
		!self.optic.get(whole)
	}
}
