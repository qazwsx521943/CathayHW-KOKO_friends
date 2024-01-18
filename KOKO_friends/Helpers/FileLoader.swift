//
//  FileLoader.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import Foundation
import Combine

enum FileLoaderError: Error {
	case noMatchingFile
}

class FileLoader {
	func loadJSONFile<T: Codable>(type: T.Type, from fileName: String) -> AnyPublisher<T, Error> {
		guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
			return Fail(error: FileLoaderError.noMatchingFile).eraseToAnyPublisher()
		}

		return URLSession.shared.dataTaskPublisher(for: url)
			.map { $0.data }
			.decode(type: type, decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}
}
