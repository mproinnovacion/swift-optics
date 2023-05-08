import Foundation

extension ArraySetterOptic {
	public func onUpdate(_ f: @escaping () -> Void) -> OnUpdateArraySetter<Self> {
		.init(optic: self, onUpdate: f)
	}
}

public struct OnUpdateArraySetter<O: ArraySetterOptic>: ArraySetterOptic {
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

	public func updatingAll(
		_ whole: O.Whole,
		_ f: @escaping (O.Part) -> O.NewPart
	) -> O.NewWhole {
		self.onUpdate()
		return self.optic.updatingAll(whole, f)
	}
}

