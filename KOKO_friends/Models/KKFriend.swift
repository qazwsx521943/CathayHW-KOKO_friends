//
//  KKFriend.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import Foundation

// curl https://dimanyen.github.io/friend1.json
struct KKFriend: Codable {
	let name: String
	let status: FriendStatus
	let isTop: String
	let fid: String
	let updateDate: String
}

// https://app.zeplin.io/project/5c498614493bf5bf68258c5a/screen/5d77637750db6d7380db8c87
enum FriendStatus: Int, Codable {
	case pending = 0
	case friend
	case inviting
}
