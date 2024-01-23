//
//  KKFriend.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import Foundation

// curl https://dimanyen.github.io/friend1.json
struct KKFriend: Codable, Equatable {
	let name: String
	let status: FriendStatus
	let isTop: String
	let fid: String
	let updateDate: Date

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(self.name, forKey: .name)
		try container.encode(self.status, forKey: .status)
		try container.encode(self.isTop, forKey: .isTop)
		try container.encode(self.fid, forKey: .fid)
		try container.encode(self.updateDate, forKey: .updateDate)
	}

	enum CodingKeys: CodingKey {
		case name
		case status
		case isTop
		case fid
		case updateDate
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.name = try container.decode(String.self, forKey: .name)
		self.status = try container.decode(FriendStatus.self, forKey: .status)
		self.isTop = try container.decode(String.self, forKey: .isTop)
		self.fid = try container.decode(String.self, forKey: .fid)
		let updateDateString = try container.decode(String.self, forKey: .updateDate)

		self.updateDate = DateFormatter.formatDateString(dateString: updateDateString)
	}
}

// https://app.zeplin.io/project/5c498614493bf5bf68258c5a/screen/5d77637750db6d7380db8c87
enum FriendStatus: Int, Codable {
	case pending = 0
	case friend
	case inviting
}
