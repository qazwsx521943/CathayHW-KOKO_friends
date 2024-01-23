//
//  DefaultEmptyFriendView.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/21.
//

import UIKit

class DefaultEmptyFriendView: UIView {

	@IBOutlet var contentView: UIView!
	
	@IBOutlet weak var addFriendButton: UIButton!

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

		let beginColor = UIColor(red: 86/255, green: 179/255, blue: 11/255, alpha: 1)
		let endColor = UIColor(red: 166/255, green: 204/255, blue: 66/255, alpha: 1)
		
		let gradientLayer = CAGradientLayer.gradientLayer(colors: (beginColor: beginColor, endColor: endColor), in: addFriendButton.bounds)
		addFriendButton.layer.addSublayer(gradientLayer)
		addFriendButton.layer.cornerRadius = 20
		addFriendButton.clipsToBounds = true
	}
}
