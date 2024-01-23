//
//  BadgeLabel.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/19.
//

import UIKit

class BadgeLabel: UILabel {

	var textInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7) {
		didSet {
			invalidateIntrinsicContentSize()
		}
	}

	override var intrinsicContentSize: CGSize {
		var size = super.intrinsicContentSize
		size.width += textInsets.left + textInsets.right
		size.height += textInsets.top + textInsets.bottom
		return size
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	private func setupView() {
		textAlignment = .center
		backgroundColor = .systemPink
		textColor = .white
		clipsToBounds = true
		font = .getKKFont(.textStyle)
	}

	override func layoutSubviews() {
		layer.cornerRadius = bounds.height / 2
	}
}
