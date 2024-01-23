//
//  Bundle+Ext.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import Foundation

extension Bundle {
	static func KKValueForString(key: String) -> String {
		return Bundle.main.infoDictionary![key] as! String
	}
}
