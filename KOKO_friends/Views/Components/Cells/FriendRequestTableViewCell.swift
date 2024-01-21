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
    }

	override func layoutSubviews() {
		avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
	}

	public func configure(friend: KKFriend) {
		self.userNameLabel.text = friend.name
	}
}
