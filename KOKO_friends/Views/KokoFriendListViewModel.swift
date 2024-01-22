//
//  KokoFriendListViewModel.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import Foundation
import Combine

class KokoFriendListViewModel {
	@Published var friendResponseType: APIRequest = .noFriends

	@Published var currentUser: KKUser?

	@Published var friendList: [KKFriend] = []

	@Published var searchedList: [KKFriend] = []

	@Published var pendingInvitation: [KKFriend] = []

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

	public func loadFriendList() {
		switch friendResponseType {
		case .noFriends, .withPendingInvitations:
			fetchFriends(type: friendResponseType.endPoints[0])
		case .noPendingInvitations:
			fetchFriendsParallel()
		}
	}

	private func fetchFriends(type: Int) {
		kokoService.getUserFriends(type: type)
			.receive(on: RunLoop.main)
			.sink { completion in
				switch completion {
				case .finished:
					print("friends fetched")
				case .failure(let error):
					print("error: \(error.localizedDescription)")
				}
			} receiveValue: { friends in
				self.friendList = friends.filter { $0.status != .pending }
				self.pendingInvitation = friends.filter { $0.status == .pending }
			}
			.store(in: &anyCancellables)
	}

	private func fetchFriendsParallel() {
		let combinedPublishers = Publishers.CombineLatest(kokoService.getUserFriends(type: 1), kokoService.getUserFriends(type: 2))
			.map { value1, value2 in
				let combinedData = value1 + value2
				let uniqueData = Dictionary(grouping: combinedData, by: { $0.fid })
					.map { $0.value.max(by: { $0.updateDate < $1.updateDate }) }
					.compactMap { $0 }
				return uniqueData
			}
			.eraseToAnyPublisher()

		combinedPublishers.sink { completion in

		} receiveValue: { friends in
			self.friendList = friends.filter { $0.status != .pending }
			self.pendingInvitation = friends.filter { $0.status == .pending }
		}
		.store(in: &anyCancellables)
	}

	public func searchFriend(keyword: String) {
		searchedList = friendList.filter { $0.name.contains(keyword) }
	}

	public func acceptFriendRequest(from friend: KKFriend) {
		if let idx = pendingInvitation.firstIndex(of: friend) {
			let acceptedFriend = pendingInvitation.remove(at: idx)
			friendList.append(acceptedFriend)
		}
	}

	public func rejectFriendRequest(from friend: KKFriend) {
		if let idx = pendingInvitation.firstIndex(of: friend) {
			pendingInvitation.remove(at: idx)
		}
	}
}
