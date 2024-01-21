//
//  DefaultEmptyFriendView.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/21.
//

import UIKit

class DefaultEmptyFriendView: UIView {

	@IBOutlet var contentView: UIView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupFromNib()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupFromNib()
	}

	private func setupFromNib() {
		Bundle.main.loadNibNamed("DefaultEmptyFriendView", owner: self)
		addSubview(contentView)
		contentView.frame = bounds
		contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
	}
}
