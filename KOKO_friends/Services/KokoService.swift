//
//  KokoService.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import Foundation
import Combine

enum KokoServiceError: Error {
	case noMatchingURL
}

protocol KokoServiceProtocol {
	func getUserData() -> AnyPublisher<KKUser, Error>

	func getUserFriends(type: Int) -> AnyPublisher<[KKFriend], Error>
}

class KokoService: KokoServiceProtocol {
	func getUserData() -> AnyPublisher<KKUser, Error> {
		guard let url = KKRequest.userData.makeRequest()
		else {
			return Fail(error: KokoServiceError.noMatchingURL).eraseToAnyPublisher()
		}
		
		return URLSession.shared.dataTaskPublisher(for: url)
			.map { $0.data }
			.decode(type: KKResponse<KKUser>.self, decoder: JSONDecoder())
			.map { $0.response.first! }
			.eraseToAnyPublisher()
	}
	
	func getUserFriends(type: Int) -> AnyPublisher<[KKFriend], Error> {
		guard let url = KKRequest.friendList(type: type).makeRequest()
		else {
			return Fail(error: KokoServiceError.noMatchingURL).eraseToAnyPublisher()
		}

		return URLSession.shared.dataTaskPublisher(for: url)
			.map { $0.data }
			.decode(type: KKResponse<KKFriend>.self, decoder: JSONDecoder())
			.map { $0.response }
			.eraseToAnyPublisher()
	}
}

