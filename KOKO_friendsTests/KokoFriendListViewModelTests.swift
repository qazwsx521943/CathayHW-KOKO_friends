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
}
