//
//  UIStoryboard+EXT.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/20.
//

import UIKit

extension UIStoryboard {
	static var main: UIStoryboard { return kkStoryboard(name: "Main") }
	static var products: UIStoryboard { return kkStoryboard(name: "Products") }
	static var friends: UIStoryboard { return kkStoryboard(name: "Friends") }
	static var home: UIStoryboard { return kkStoryboard(name: "Home") }
	static var manage: UIStoryboard { return kkStoryboard(name: "Manage") }
	static var setting: UIStoryboard { return kkStoryboard(name: "Setting") }

	private static func kkStoryboard(name: String) -> UIStoryboard {
		return UIStoryboard(name: name, bundle: nil)
	}
}
