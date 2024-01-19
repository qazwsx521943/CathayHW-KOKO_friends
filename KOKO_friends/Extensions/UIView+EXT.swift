//
//  UIView+EXT.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/19.
//

import UIKit

extension UIView {
	func pin(_ view: UIView) {
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: topAnchor),
			view.leadingAnchor.constraint(equalTo: leadingAnchor),
			view.trailingAnchor.constraint(equalTo: trailingAnchor),
			view.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
