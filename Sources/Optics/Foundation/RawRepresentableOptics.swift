import Foundation

extension RawRepresentable {
	public static func rawValueOptic() -> some SimpleOptionalOptic<Self, RawValue> {
		OptionalRawOptic { representable in
			representable.rawValue
		} tryUpdating: { representable, update in
			Self(rawValue: update(representable.rawValue)) ?? representable
		} trySetting: { representable, newValue in
			Self(rawValue: newValue) ?? representable
		}
	}
}

extension RawRepresentable {
	public static func prismOptic() -> some PrismOptic<RawValue, Self> {
		PrismRawOptic { rawValue in
			.init(rawValue: rawValue)
		} embed: { representable in
			representable.rawValue
		}
	}
}
