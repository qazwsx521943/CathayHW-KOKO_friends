//
//  BadgeLabel.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/19.
//

import UIKit
import SwiftUI

class BadgeLabelView: UIView {
	private let labelButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.isUserInteractionEnabled = true
		button.titleLabel?.textAlignment = .center
		button.titleLabel?.font = .getKKFont(.textStyle)
		button.setTitleColor(.black, for: .normal)
		button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		return button
	}()

	private let badgeLabel: BadgeLabel = {
		let label = BadgeLabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.backgroundColor = .accent
		return label
	}()

	var buttonTapped: (() -> ())?

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	private func setupView() {
		addSubview(labelButton)
		addSubview(badgeLabel)

		labelButton.addTarget(self, action: #selector(triggerButtonTap), for: .touchUpInside)

		NSLayoutConstraint.activate([
			labelButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			labelButton.centerYAnchor.constraint(equalTo: centerYAnchor),

			badgeLabel.centerYAnchor.constraint(equalTo: labelButton.topAnchor),
			badgeLabel.leadingAnchor.constraint(equalTo: labelButton.trailingAnchor),
		])
	}

	@objc fileprivate func triggerButtonTap() {
		buttonTapped?()
	}

	public func setTitle(_ text: String) {
		self.labelButton.setTitle(text, for: .normal)
	}

	public func updateBadgeValue(_ value: Int) {
		self.badgeLabel.text = "\(value)\(value >= 99 ? "+" : "")"
	}
}

struct SwiftUIBadgeLabel: UIViewRepresentable {
	func makeUIView(context: Context) -> BadgeLabelView {
		let badge = BadgeLabelView()
		badge.updateBadgeValue(2)
		badge.setTitle("好友")
		return badge
	}

	func updateUIView(_ uiView: BadgeLabelView, context: Context) {

	}
}

struct BadgeLabel_Preview: PreviewProvider {
	static var previews: some View {
		SwiftUIBadgeLabel()
			.frame(width: 50, height: 50)
	}
}
