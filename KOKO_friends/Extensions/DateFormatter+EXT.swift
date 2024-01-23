//
//  DateFormatter+EXT.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/23.
//

import Foundation

extension DateFormatter {
	static func formatDateString(dateString: String) -> Date {
		let formatter = DateFormatter()
		formatter.dateFormat = dateString.contains("/") ? "yyyy/MM/dd" : "yyyyMMdd"

		return formatter.date(from: dateString)!
	}
}
