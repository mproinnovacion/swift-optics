import Foundation

extension ThrowingSetterOptic {
	public func onUpdate(_ f: @escaping () -> Void) -> OnUpdateThrowingSetter<Self> {
		.init(optic: self, onUpdate: f)
	}
}

public struct OnUpdateThrowingSetter<O: ThrowingSetterOptic>: ThrowingSetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	public typealias NewWhole = O.NewWhole
	public typealias NewPart = O.NewPart
	
	public let optic: O
	public let onUpdate: () -> Void
	
	public init(
		optic: O,
		onUpdate: @escaping () -> Void
	) {
		self.optic = optic
		self.onUpdate = onUpdate
	}

	public func updating(
		_ whole: O.Whole,
		_ f: @escaping (O.Part) throws -> O.NewPart
	) throws -> O.NewWhole {
		self.onUpdate()
		return try self.optic.updating(whole, f)
	}
}

