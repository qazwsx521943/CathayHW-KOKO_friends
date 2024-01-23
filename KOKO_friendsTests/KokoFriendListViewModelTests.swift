//
//  KOKO_friendsTests.swift
//  KOKO_friendsTests
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import XCTest
import Combine
@testable import KOKO_friends

final class KokoFriendListViewModelTests: XCTestCase {
	var cancellables: Set<AnyCancellable> = []

	func test_FetchCurrentUser_Success() {
		let expectation = XCTestExpectation(description: "Fetch user succeeded!")

		let mockService = MockKokoService()
		let viewModel = KokoFriendListViewModel(kokoService: mockService)
		viewModel.fetchUser()

		let cancellable = viewModel.$currentUser
			.sink { user in
				if user != nil {
					expectation.fulfill()
				}
			}

		wait(for: [expectation], timeout: 1.0)

		XCTAssertNotNil(viewModel.currentUser)
		cancellable.cancel()
	}

	func test_FetchCurrentUser_Failure() {
		let expectation = XCTestExpectation(description: "Fetch user failed!")

		let mockService = MockKokoService(failCase: true)
		let viewModel = KokoFriendListViewModel(kokoService: mockService)
		let cancellable = viewModel.$currentUser
			.sink { user in
				if user == nil {
					expectation.fulfill()
				}
			}

		wait(for: [expectation], timeout: 1.0)

		XCTAssertNil(viewModel.currentUser)
		cancellable.cancel()
	}

	func test_fetchFriendsParallel_count() {
		let expectation = XCTestExpectation(description: "fetchFriends with 2 request")

		let mockService = MockKokoService()
		let viewModel = KokoFriendListViewModel(kokoService: mockService)
		viewModel.friendResponseType = .noPendingInvitations
		viewModel.loadFriendList()

		let cancellable = viewModel.$friendList
			.dropFirst(1)
			.sink { friends in
				expectation.fulfill()
			}

		wait(for: [expectation], timeout: 5.0)
		XCTAssertEqual(viewModel.friendList.count, 6)
		XCTAssertEqual(viewModel.pendingInvitation.count, 0)
		cancellable.cancel()
	}

	func test_searchFriendByKeyword_count() {
		let expectation = XCTestExpectation(description: "filter friendlist fulfilled")
		let mockService = MockKokoService()
		let viewModel = KokoFriendListViewModel(kokoService: mockService)

		viewModel.friendResponseType = .withPendingInvitations
		viewModel.friendList = [
			KKFriend(name: "黃色閃光", status: .friend, isTop: "1", fid: "001", updateDate: Date())
		]
		viewModel.searchFriend(keyword: "黃")

		let Cancellable = viewModel.$searchedList
			.sink { _ in
				expectation.fulfill()
			}

		wait(for: [expectation], timeout: 1.0)
		XCTAssertEqual(viewModel.searchedList.count, 1)
		Cancellable.cancel()
	}
}
