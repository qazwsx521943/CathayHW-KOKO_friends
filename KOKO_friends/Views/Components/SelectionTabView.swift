//
//  SelectionTabView.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/19.
//

import UIKit
import SwiftUI

protocol SelectionTabViewDelegate: AnyObject {
	func selectionTabViewTabsCount(_ selectionTabView: SelectionTabView) -> Int

	func selectionTabView(_ selectionTabView: SelectionTabView, textForTabAt: IndexPath) -> String
}

class SelectionTabView: UIView {
	var stackView: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .horizontal
		view.alignment = .center
		view.distribution = .fillEqually
		view.spacing = 10
		return view
	}()

	var indicatorView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		view.layer.cornerRadius = 1
		view.backgroundColor = .systemPink
		return view
	}()

	var indicatorViewConstraint: NSLayoutConstraint!

	var currentSelection: IndexPath = .init(row: 0, section: 0)

	weak var delegate: SelectionTabViewDelegate? {
		didSet {
			setupView()
		}
	}

	// MARK: - Initializers
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	private func setupView() {
		addSubview(stackView)
		addSubview(indicatorView)

		pin(stackView)

		guard let tabCount = delegate?.selectionTabViewTabsCount(self) else {
			return
		}

		for i in 0..<tabCount {
			let tabLabel = BadgeLabelView()
			tabLabel.translatesAutoresizingMaskIntoConstraints = false

			if let text = delegate?.selectionTabView(self, textForTabAt: IndexPath(row: i, section: 0)) {
				tabLabel.setTitle(text)
				tabLabel.updateBadgeValue(2)
			}
			tabLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
			tabLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

			tabLabel.buttonTapped = { [weak self] in
				self?.indicatorViewConstraint.isActive = false
				self?.indicatorViewConstraint = self?.indicatorView.centerXAnchor.constraint(equalTo: tabLabel.centerXAnchor)
				self?.indicatorViewConstraint.isActive = true

				UIView.animate(withDuration: 0.3, animations: { [weak self] in
					self?.layoutIfNeeded()
				})
			}

			stackView.addArrangedSubview(tabLabel)
			indicatorViewConstraint = indicatorView.centerXAnchor.constraint(equalTo: stackView.subviews[0].centerXAnchor)
		}
		
		NSLayoutConstraint.activate([
			indicatorView.widthAnchor.constraint(equalToConstant: 20),
			indicatorView.heightAnchor.constraint(equalToConstant: 4),
			indicatorView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
		])
		indicatorViewConstraint.isActive = true
	}
}

// MARK: Preview
struct SelectionView_Preview: PreviewProvider {
	static var previews: some View {
		SwiftUISelectionTabView()
			.frame(width: 200, height: 50)
	}
}

struct SwiftUISelectionTabView: UIViewRepresentable {
	func makeUIView(context: Context) -> SelectionTabView {
		let view = SelectionTabView()
		view.delegate = context.coordinator
		return view
	}

	func updateUIView(_ uiView: SelectionTabView, context: Context) {
	}

	func makeCoordinator() -> Coordinator {
		return Coordinator()
	}

	class Coordinator: SelectionTabViewDelegate {
		func selectionTabViewTabsCount(_ selectionTabView: SelectionTabView) -> Int {
			3
		}

		func selectionTabView(_ selectionTabView: SelectionTabView, textForTabAt: IndexPath) -> String {
			"好友"
		}
	}
}
