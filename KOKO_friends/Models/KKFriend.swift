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
	let status: Int
	let isTop: String
	let fid: String
	let updateDate: String
}
