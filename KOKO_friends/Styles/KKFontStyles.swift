//
//  KKFontStyles.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import Foundation
import UIKit

protocol FontStyle {
	static var baseFont: String { get }

	var size: CGFloat { get }

	func makeFont() -> UIFont
}

// style guide ref: https://app.zeplin.io/project/5c498614493bf5bf68258c5a/styleguide/textstyles
enum KKFontStyle: FontStyle {
	case textStyle4
	case textStyle3
	case textStyle2
	case textStyle

	static let baseFont: String = "PingFangTC"

	var size: CGFloat {
		switch self {
		case .textStyle4: return 17
		case .textStyle3: return 16
		case .textStyle2, .textStyle: return 13
		}
	}

	var fontWeight: FontWeight {
		switch self {
		case .textStyle4, .textStyle2: return .medium
		case .textStyle3, .textStyle: return .regular
		}
	}

	enum FontWeight: String {
		case regular = "Regular"
		case medium = "Medium"
	}
}

extension KKFontStyle {
	func makeFont() -> UIFont {
		UIFont(name: "\(Self.baseFont)-\(fontWeight)", size: size)!
	}
}

