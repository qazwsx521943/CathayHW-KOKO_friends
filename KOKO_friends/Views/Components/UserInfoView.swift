//
//  UserInfoView.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import UIKit

class UserInfoView: UIView {
	// MARK: - Properties
	let imageView: UIImageView = {
		let view = UIImageView()
		view.clipsToBounds = true
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFill
		return view
	}()

	let usernameLabel: UILabel = {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.font = .getKKFont(.textStyle4)
		return view
	}()

	let kokoIdKeyLabel: UILabel = {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.font = .getKKFont(.textStyle)
		view.text = "KOKO ID: "
		return view
	}()

	let kokoIdValueLabel: UILabel = {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.font = .getKKFont(.textStyle)
		return view
	}()

	// MARK: - Initializers
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override func layoutSubviews() {
		imageView.layer.cornerRadius = imageView.bounds.height / 2
	}

	// MARK: - Private func
	private func setupView() {
		addSubview(imageView)
		addSubview(usernameLabel)
		addSubview(kokoIdKeyLabel)
		addSubview(kokoIdValueLabel)

		NSLayoutConstraint.activate([
			imageView.widthAnchor.constraint(equalToConstant: 52),
			imageView.heightAnchor.constraint(equalToConstant: 52),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
			imageView.centerYAnchor.constraint(equalTo: centerYAnchor),

			usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
			usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),

			kokoIdKeyLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
			kokoIdKeyLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),

			kokoIdValueLabel.leadingAnchor.constraint(equalTo: kokoIdKeyLabel.trailingAnchor),
			kokoIdValueLabel.topAnchor.constraint(equalTo: kokoIdKeyLabel.topAnchor)
		])
	}
}
