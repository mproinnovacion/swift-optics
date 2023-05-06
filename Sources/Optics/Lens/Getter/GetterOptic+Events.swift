import Foundation

extension GetterOptic {
	public func onGet(_ f: @escaping () -> Void) -> OnGetGetter<Self> {
		.init(optic: self, onGet: f)
	}
}

public struct OnGetGetter<O: GetterOptic>: GetterOptic {
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

	public func get(_ whole: O.Whole) -> O.Part {
		self.onGet()
		return self.optic.get(whole)
	}
}

