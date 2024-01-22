//
//  ViewController.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/18.
//

import UIKit
import Combine

class KokoFriendListViewController: UIViewController {

	// MARK: - Properties
	lazy var requestTypeSegmentControl: UISegmentedControl = {
		let segmentControl = UISegmentedControl(items: APIRequest.situations)
		segmentControl.translatesAutoresizingMaskIntoConstraints = false
		segmentControl.addTarget(self, action: #selector(requestTypeChanged), for: .valueChanged)
		segmentControl.selectedSegmentIndex = 0
		return segmentControl
	}()

	private var userInfoView: UserInfoView = {
		let view = UserInfoView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	lazy var friendRequestTableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.isScrollEnabled = false
		tableView.kk_registerCellWithNib(identifier: FriendRequestTableViewCell.identifier, bundle: nil)
		return tableView
	}()
	private var friendRequestTableViewHeightConstraint: NSLayoutConstraint!

	lazy var selectionTab: SelectionTabView = {
		let view = SelectionTabView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.delegate = self
		return view
	}()

	private var divider: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .divider
		return view
	}()

	private var containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	lazy var defaultEmptyView: UIViewController = {
		self.makeEmptyFriendListVC()
	}()

	lazy var friendListVC: KKSearchableFriendListViewController = {
		let vc = KKSearchableFriendListViewController(viewModel: kokoFriendListViewModel)
		vc.view.translatesAutoresizingMaskIntoConstraints = false
		return vc
	}()

	private var kokoFriendListViewModel = KokoFriendListViewModel()
	private var bindings = Set<AnyCancellable>()

	// MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupBindings()
		kokoFriendListViewModel.fetchUser()
		kokoFriendListViewModel.loadFriendList()
	}

	@objc fileprivate func requestTypeChanged(sender: UISegmentedControl) {
		kokoFriendListViewModel.friendResponseType = APIRequest(rawValue: sender.selectedSegmentIndex) ?? .noFriends
	}

	private func toggleFriendRequestConstraint(height: CGFloat) {
		friendRequestTableViewHeightConstraint.isActive = false
		friendRequestTableViewHeightConstraint = friendRequestTableView.heightAnchor.constraint(equalToConstant: height)

		friendRequestTableViewHeightConstraint.isActive = true
	}

	// MARK: - Private func
	private func setupView() {
		view.addSubview(requestTypeSegmentControl)
		view.addSubview(userInfoView)
		view.addSubview(friendRequestTableView)
		view.addSubview(selectionTab)
		view.addSubview(divider)
		view.addSubview(containerView)

		userInfoView.imageView.image = UIImage(resource: .hisoka)

		NSLayoutConstraint.activate([
			requestTypeSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			requestTypeSegmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			requestTypeSegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			userInfoView.topAnchor.constraint(equalTo: requestTypeSegmentControl.bottomAnchor),
			userInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			userInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			userInfoView.heightAnchor.constraint(equalToConstant: 60),

			friendRequestTableView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: 28),
			friendRequestTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			friendRequestTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

			selectionTab.topAnchor.constraint(equalTo: friendRequestTableView.bottomAnchor),
			selectionTab.heightAnchor.constraint(equalToConstant: 30),
			selectionTab.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
			selectionTab.widthAnchor.constraint(equalToConstant: 150),

			divider.heightAnchor.constraint(equalToConstant: 1),
			divider.topAnchor.constraint(equalTo: selectionTab.bottomAnchor, constant: -1),
			divider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			divider.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			containerView.topAnchor.constraint(equalTo: selectionTab.bottomAnchor),
			containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])

		friendRequestTableViewHeightConstraint = friendRequestTableView.heightAnchor.constraint(equalToConstant: 80)
		friendRequestTableViewHeightConstraint.isActive = true
	}

	private func setupBindings() {
		bindings = [
			kokoFriendListViewModel.$currentUser.map { $0?.name }.assign(to: \.text, on: userInfoView.usernameLabel),
			kokoFriendListViewModel.$currentUser.map { $0?.kokoid }.assign(to: \.text, on: userInfoView.kokoIdValueLabel)
		]

		kokoFriendListViewModel.$friendResponseType
			.receive(on: RunLoop.main)
			.sink { [weak self] type in
				self?.kokoFriendListViewModel.loadFriendList()
			}
			.store(in: &bindings)

		kokoFriendListViewModel.$friendList
			.receive(on: RunLoop.main)
			.sink { [weak self] friends in
				print(friends.map { $0.name })
				if friends.count == 0 {
					self?.showEmptyListView()
					self?.removeFriendListView()
				} else {
					self?.removeEmptyListView()
					self?.showFriendListView()
//					self?.friendListVC.reloadData()
					self?.friendRequestTableView.reloadData()
				}
				self?.selectionTab.updateBadgeValue()
			}
			.store(in: &bindings)

		kokoFriendListViewModel.$pendingInvitation
			.receive(on: RunLoop.main)
			.sink { [weak self] invitations in
				self?.toggleFriendRequestConstraint(height: invitations.count == 0 ? 0 : 80)
				self?.friendRequestTableView.reloadData()
			}
			.store(in: &bindings)
	}

	private func makeEmptyFriendListVC() -> UIViewController {
		let vc = UIViewController()
		let defaultEmptyFriendView = DefaultEmptyFriendView()
		defaultEmptyFriendView.translatesAutoresizingMaskIntoConstraints = false
		vc.view.translatesAutoresizingMaskIntoConstraints = false
		vc.view.addSubview(defaultEmptyFriendView)
		vc.view.pin(defaultEmptyFriendView)
		return vc
	}

	private func showFriendListView() {
		containerView.addSubview(friendListVC.view)
		containerView.pin(friendListVC.view)
	}

	private func removeFriendListView() {
		friendListVC.view.removeFromSuperview()
	}

	private func showEmptyListView() {
		add(defaultEmptyView)
		containerView.pin(defaultEmptyView.view)
	}

	private func removeEmptyListView() {
		defaultEmptyView.remove()
	}
}

extension KokoFriendListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		70
	}
}

extension KokoFriendListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		kokoFriendListViewModel.pendingInvitation.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendRequestTableViewCell.identifier, for: indexPath) as? FriendRequestTableViewCell else {
			return UITableViewCell()
		}
		let friend = kokoFriendListViewModel.pendingInvitation[indexPath.row]

		cell.acceptButtonClosure = { [weak self] in
			self?.kokoFriendListViewModel.acceptFriendRequest(from: friend)
		}

		cell.rejectButtonClosure = { [weak self] in
			self?.kokoFriendListViewModel.rejectFriendRequest(from: friend)
		}

		cell.configure(friend: friend)
		return cell
	}
}

extension KokoFriendListViewController: SelectionTabViewDelegate {
	func selectionTabView(_ selectionTabView: SelectionTabView, badgeValueForTabAt: IndexPath) -> Int {
		switch badgeValueForTabAt.row {
		case 0: return kokoFriendListViewModel.friendList.filter { $0.isTop == "1" }.count
		default: return 99
		}
	}
	
	func selectionTabViewTabsCount(_ selectionTabView: SelectionTabView) -> Int {
		2
	}
	
	func selectionTabView(_ selectionTabView: SelectionTabView, textForTabAt: IndexPath) -> String {
		switch textForTabAt.row {
		case 0: return "好友"
		case 1: return "聊天"
		default: return "無"
		}
	}
}
