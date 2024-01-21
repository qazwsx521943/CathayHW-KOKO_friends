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

	func shadowEffect(cornerRadius: CGFloat) {
		let size = bounds.size
		let width = size.width
		let height = size.height

		let ovalRect = CGRect(x: 5, y: height + 5, width: width - 10, height: 15)

		layer.shadowPath = UIBezierPath(roundedRect: ovalRect, cornerRadius: cornerRadius).cgPath
//		layer.masksToBounds = false
		layer.shadowRadius = 10
		layer.shadowColor = UIColor.gray.cgColor
		layer.shadowOpacity = 0.5
		layer.shadowOffset = CGSize(width: 10, height: 10)
	}
}
