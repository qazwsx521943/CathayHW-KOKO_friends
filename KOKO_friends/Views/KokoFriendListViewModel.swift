//
//  KokoFriendListViewModel.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import Foundation
import Combine

class KokoFriendListViewModel {
	@Published var currentUser: KKUser?

	private let kokoService: KokoServiceProtocol

	private var anyCancellables = Set<AnyCancellable>()

	init(kokoService: KokoServiceProtocol = KokoService()) {
		self.kokoService = kokoService
	}

	public func fetchUser() {
		kokoService.getUserData()
			.receive(on: RunLoop.main)
			.sink { completion in
				switch completion {
				case .finished:
					print("user fetched")
				case .failure(let error):
					print("error: \(error.localizedDescription)")
				}
			} receiveValue: { user in
				self.currentUser = user
			}
			.store(in: &anyCancellables)
	}
}
