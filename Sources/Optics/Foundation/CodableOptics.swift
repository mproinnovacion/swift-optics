import Foundation

extension Decodable where Self: Encodable {
	public static var defaultEncoder: JSONEncoder {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		encoder.dateEncodingStrategy = .secondsSince1970
		return encoder
	}
	
	public static var defaultDecoder: JSONDecoder {
		let encoder = JSONDecoder()
		encoder.dateDecodingStrategy = .secondsSince1970
		return encoder
	}
	
	public static func codableOptic(
		decoder: JSONDecoder = defaultDecoder,
		encoder: JSONEncoder = defaultEncoder
	) -> some SimpleOptionalOptic<Data, Self> {
		OptionalRawOptic { data in
			do {
				return try decoder.decode(Self.self, from: data)
			}
			catch {
				dump(error)
				return nil
			}
		} tryUpdate: { data, update in
			let object = try? decoder.decode(Self.self, from: data)
			return object.map(update).flatMap { try? encoder.encode($0) } ?? data
		} trySet: { data, newObject in
			do {
				return try encoder.encode(newObject)
			}
			catch {
				dump(error)
				
				return data
			}
		}
	}
}
