//
//  FriendRequestTableViewCell.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/19.
//

import UIKit

class FriendRequestTableViewCell: UITableViewCell {

	var acceptButtonClosure: (() -> ())?

	var rejectButtonClosure: (() -> ())?

	@IBOutlet weak var containerView: UIView! {
		didSet {
			containerView.layer.shadowOpacity = 1.0
			containerView.layer.shadowOffset = .init(width: 0, height: 4)
			containerView.layer.shadowColor = UIColor.shadow.cgColor
			containerView.layer.shadowRadius = 4
			containerView.layer.cornerRadius = 6
		}
	}

	@IBOutlet weak var containerBackgroundView: UIView! {
		didSet {
			containerBackgroundView.layer.shadowOpacity = 1.0
			containerBackgroundView.layer.shadowOffset = .init(width: 0, height: 4)
			containerBackgroundView.layer.shadowColor = UIColor.shadow.cgColor
			containerBackgroundView.layer.shadowRadius = 4
			containerBackgroundView.layer.cornerRadius = 6
		}
	}

	@IBOutlet weak var userNameLabel: UILabel!

	@IBOutlet weak var avatarImageView: UIImageView!

	@IBAction func acceptButtonTapped(_ sender: Any) {
		acceptButtonClosure?()
	}
	
	@IBAction func rejectButtonTapped(_ sender: Any) {
		rejectButtonClosure?()
	}

	override func awakeFromNib() {
        super.awakeFromNib()
		selectionStyle = .none
    }

	override func layoutSubviews() {
		avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
	}

	public func configure(friend: KKFriend, isExpand: Bool) {
		self.userNameLabel.text = friend.name
		self.containerBackgroundView.isHidden = isExpand
	}
}
