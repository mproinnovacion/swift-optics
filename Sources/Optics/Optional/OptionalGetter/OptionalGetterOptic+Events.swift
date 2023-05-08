import Foundation

extension OptionalGetterOptic {
	public func onGet(_ f: @escaping () -> Void) -> OnGetOptionalGetter<Self> {
		.init(optic: self, onGet: f)
	}
}

public struct OnGetOptionalGetter<O: OptionalGetterOptic>: OptionalGetterOptic {
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

	public func tryGet(_ whole: O.Whole) -> O.Part? {
		self.onGet()
		return self.optic.tryGet(whole)
	}
}


