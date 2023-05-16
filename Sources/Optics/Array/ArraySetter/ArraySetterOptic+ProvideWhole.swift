import Foundation

public struct ArraySetterProvidedWholeOptic<O: ArraySetterOptic>: ArraySetterOptic {
	public typealias Whole = Void
	public typealias Part = O.Part
	public typealias NewWhole = O.NewWhole
	public typealias NewPart = O.NewPart
	
	public let optic: O
	public let whole: O.Whole
	
	public init(
		optic: O,
		whole: O.Whole
	) {
		self.optic = optic
		self.whole = whole
	}
	
	public func updatingAll(
		in void: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updatingAll(in: self.whole, update: f)
	}
}

extension ArraySetterOptic {
	public func provide(
		_ whole: Whole
	) -> ArraySetterProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension ArraySetterOptic where Whole == Void {
	public func updatingAll(
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.updatingAll(in: (), update: f)
	}
	
	public func settingAll(
		to newPart: NewPart
	) -> NewWhole {
		self.settingAll(in: (), to: newPart)
	}
}
