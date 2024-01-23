//
//  UIFont+EXT.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import UIKit

extension UIFont {
	class func getKKFont(_ fontStyle: KKFontStyle) -> UIFont {
		fontStyle.makeFont()
	}
}
