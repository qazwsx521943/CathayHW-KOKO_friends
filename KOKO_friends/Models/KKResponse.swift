//
//  KKResponse.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import Foundation

struct KKResponse<T: Codable>: Codable {
	let response: [T]
}
