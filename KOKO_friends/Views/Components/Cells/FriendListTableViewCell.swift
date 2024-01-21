//
//  FriendListTableViewCell.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/21.
//

import UIKit

class FriendListTableViewCell: UITableViewCell {

	@IBOutlet weak var isTopImageView: UIImageView!

	@IBOutlet weak var userNameLabel: UILabel!

	@IBOutlet weak var transferButtonTrailingConstraint: NSLayoutConstraint!

	@IBOutlet weak var configurationImageView: UIImageView!

	@IBOutlet weak var transferButton: UIButton! {
		didSet {
			transferButton.layer.cornerRadius = 2
			transferButton.layer.borderWidth = 1.2
			transferButton.layer.borderColor = UIColor.accent.cgColor
		}
	}

	lazy var invitingButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(button)
		button.setTitle("邀請中", for: .normal)
		button.setTitleColor(.kkGray, for: .normal)
		button.titleLabel?.font = .getKKFont(.textStyle2)
		button.contentEdgeInsets = .init(top: 2, left: 9, bottom: 2, right: 9)
		button.layer.cornerRadius = 2
		button.layer.borderWidth = 1.2
		button.layer.borderColor = UIColor.kkGray.cgColor
		return button
	}()

	private var showInvitingButton: Bool = false {
		didSet {
			setInvitingButtonConstraint(show: showInvitingButton)
		}
	}

	lazy var invitingButtonConstraints: [NSLayoutConstraint] = {
		return [
			invitingButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			invitingButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		]
	}()

	override func awakeFromNib() {
        super.awakeFromNib()
    }

	public func configure(friend: KKFriend) {
		userNameLabel.text = friend.name
		isTopImageView.isHidden = friend.isTop == "0"

		if friend.status == .inviting {
			blockConfigurationView()
		}
	}

	override func prepareForReuse() {
		transferButtonTrailingConstraint.isActive = false

		showInvitingButton = false

		configurationImageView.isHidden = false
		transferButtonTrailingConstraint = transferButton.trailingAnchor.constraint(equalTo: configurationImageView.leadingAnchor, constant: -10)
		transferButtonTrailingConstraint.isActive = true
	}

	private func setInvitingButtonConstraint(show: Bool) {
		invitingButton.isHidden = !show
		invitingButtonConstraints.forEach { constraint in
			constraint.isActive = show
		}
	}

	private func blockConfigurationView() {
		configurationImageView.isHidden = true
		showInvitingButton = true

		transferButtonTrailingConstraint.isActive = false
		transferButtonTrailingConstraint = transferButton.trailingAnchor.constraint(equalTo: invitingButton.leadingAnchor, constant: -10)
		transferButtonTrailingConstraint.isActive = true
	}
}
