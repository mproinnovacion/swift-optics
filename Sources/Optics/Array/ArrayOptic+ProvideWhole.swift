import Foundation

public struct ArrayProvidedWholeOptic<O: ArrayOptic>: ArrayOptic {
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
	
	public func getAll(_ whole: Void) -> [O.Part] {
		self.optic.getAll(self.whole)
	}
	
	public func updatingAll(
		in void: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updatingAll(in: self.whole, update: f)
	}
}

extension ArrayOptic {
	public func provide(
		_ whole: Whole
	) -> ArrayProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension ArrayOptic where Whole == Void {
	public func getAll() -> [Part] {
		self.getAll(())
	}
	
	public func updatingAll(
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.updatingAll(in: (), update: f)
	}
	
	public func settingAll(
		to newValue: NewPart
	) -> NewWhole {
		self.settingAll(in: (), to: newValue)
	}
}
