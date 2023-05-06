import Foundation

extension ArrayGetterOptic {
	public func onGet(_ f: @escaping () -> Void) -> OnGetArrayGetter<Self> {
		.init(optic: self, onGet: f)
	}
}

public struct OnGetArrayGetter<O: ArrayGetterOptic>: ArrayGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	public let onGet: () -> Void
	
	public init(
		optic: O,
		onGet: @escaping () -> Void
	) {
		self.optic = optic
		self.onGet = onGet
	}

	public func getAll(_ whole: O.Whole) -> [O.Part] {
		self.onGet()
		return self.optic.getAll(whole)
	}
}

