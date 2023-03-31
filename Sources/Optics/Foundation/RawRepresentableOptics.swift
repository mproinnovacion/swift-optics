import Foundation

extension RawRepresentable {
	public static func rawValueOptic(
	) -> some SimpleOptionalOptic<Self, RawValue> {
		OptionalRawOptic { representable in
			representable.rawValue
		} tryUpdate: { representable, update in
			Self(rawValue: update(representable.rawValue)) ?? representable
		} trySet: { representable, newValue in
			Self(rawValue: newValue) ?? representable
		}
	}
}
