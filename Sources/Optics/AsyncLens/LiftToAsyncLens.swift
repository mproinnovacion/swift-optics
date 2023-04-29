import Foundation

public struct LiftLensToAsync<O: LensOptic>: AsyncLensOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	public typealias NewWhole = O.NewWhole
	public typealias NewPart = O.NewPart
	
	let optic: O
	public init(
		optic: O
	) {
		self.optic = optic
	}
	
	public func get(_ whole: Whole) async -> Part {
		self.optic.get(whole)
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		let part = self.optic.get(whole)
		let newPart = try await f(part)
		return self.optic.setting(whole, to: newPart)
	}
}
