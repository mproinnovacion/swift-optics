import Foundation

extension SetterOptic {
	public func onUpdate(_ f: @escaping () -> Void) -> OnUpdateSetter<Self> {
		.init(optic: self, onUpdate: f)
	}
}

public struct OnUpdateSetter<O: SetterOptic>: SetterOptic {
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
		in whole: O.Whole,
		update f: @escaping (O.Part) -> O.NewPart
	) -> O.NewWhole {
		self.onUpdate()
		return self.optic.updating(in: whole, update: f)
	}
}

