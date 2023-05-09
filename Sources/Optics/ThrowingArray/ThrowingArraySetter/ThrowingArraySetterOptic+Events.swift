import Foundation

extension ThrowingArraySetterOptic {
	public func onUpdate(_ f: @escaping () -> Void) -> OnUpdateThrowingArraySetter<Self> {
		.init(optic: self, onUpdate: f)
	}
}

public struct OnUpdateThrowingArraySetter<O: ThrowingArraySetterOptic>: ThrowingArraySetterOptic {
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
		in whole: O.Whole,
		update f: @escaping (O.Part) throws -> O.NewPart
	) throws -> O.NewWhole {
		self.onUpdate()
		return try self.optic.updatingAll(in: whole, update: f)
	}
}

