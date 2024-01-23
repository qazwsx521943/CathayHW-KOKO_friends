//
//  UIViewController+EXT.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/21.
//

import UIKit

extension UIViewController {
	func add(_ child: UIViewController) {
		addChild(child)
		view.addSubview(child.view)
		child.didMove(toParent: self)
	}

	func remove() {
		guard parent != nil else {
			return
		}

		willMove(toParent: nil)
		view.removeFromSuperview()
		removeFromParent()
	}
}
