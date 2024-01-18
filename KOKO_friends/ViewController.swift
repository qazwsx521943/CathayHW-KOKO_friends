//
//  ViewController.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import UIKit
import Combine

class ViewController: UIViewController {

	// MARK: - Properties
	private var userInfoView: UserInfoView = {
		let view = UserInfoView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private var subscriptions = Set<AnyCancellable>()

	private var kokoFriendListViewModel = KokoFriendListViewModel()

	// MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupBindings()
		kokoFriendListViewModel.fetchUser()
	}

	// MARK: - Private func
	private func setupView() {
		view.addSubview(userInfoView)
		
		userInfoView.imageView.image = UIImage(resource: .hisoka)

		NSLayoutConstraint.activate([
			userInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			userInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			userInfoView.widthAnchor.constraint(equalTo: view.widthAnchor),
			userInfoView.heightAnchor.constraint(equalToConstant: 60)
		])
	}

	private func setupBindings() {
		subscriptions = [
			kokoFriendListViewModel.$currentUser.map { $0?.name }.assign(to: \.text, on: userInfoView.usernameLabel),
			kokoFriendListViewModel.$currentUser.map { $0?.kokoid }.assign(to: \.text, on: userInfoView.kokoIdValueLabel)
		]
	}
}

