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
