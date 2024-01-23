//
//  KokoRequest.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import Foundation

protocol KKRequestProtocol {
	var endPoint: String { get }
}

extension KKRequestProtocol {
	func makeRequest() -> URL? {
		let url = Bundle.KKValueForString(key: "BaseURL") + endPoint
		return URL(string: url)
	}
}

enum KKRequest: KKRequestProtocol {
	case userData
	case friendList(type: Int)

	var endPoint: String {
		switch self {
		case .userData: 
			return "/man.json"
		case .friendList(let type): 
			return "/friend\(type).json"
		}
	}
}

enum APIRequest: Int, CaseIterable {
	case noFriends = 0
	case noPendingInvitations
	case withPendingInvitations

	static let situations = Self.allCases.map { $0.title }

	var endPoints: [Int] {
		switch self {
		case .noFriends: return [4]
		case .noPendingInvitations: return [1, 2]
		case .withPendingInvitations: return [3]
		}
	}

	var title: String {
		switch self {
		case .noFriends: "無好友"
		case .noPendingInvitations: "無待接受邀請"
		case .withPendingInvitations: "有待接受邀請"
		}
	}
}
