//
//  MockKokoService.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import Foundation
import Combine

class MockKokoService: KokoServiceProtocol {
	private var failCase: Bool

	init(failCase: Bool = false) {
		self.failCase = failCase
	}

	func getUserData() -> AnyPublisher<KKUser, Error> {
		if failCase {
			return Fail(error: KokoServiceError.noMatchingURL).eraseToAnyPublisher()
		} else {
			return FileLoader().loadJSONFile(type: KKResponse<KKUser>.self, from: "man")
				.map { $0.response.first! }
				.eraseToAnyPublisher()
		}
	}
	
	func getUserFriends(type: Int) -> AnyPublisher<[KKFriend], Error> {
		return FileLoader().loadJSONFile(type: KKResponse<KKFriend>.self, from: "friend\(type)")
			.map { $0.response }
			.eraseToAnyPublisher()
	}
}
