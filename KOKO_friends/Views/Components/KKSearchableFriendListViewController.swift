//
//  SearchableFriendListViewController.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/21.
//

import UIKit
import SwiftUI
import Combine

class KKSearchableFriendListViewController: UIViewController {

	lazy var searchBar: UISearchBar = {
		let searchBar = UISearchBar()
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		searchBar.placeholder = "想轉一筆給誰呢？"
		searchBar.searchBarStyle = .minimal
		searchBar.delegate = self
		return searchBar
	}()

	private var addFriendButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(.icBtnAddFriends, for: .normal)
		return button
	}()

	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.kk_registerCellWithNib(identifier: FriendListTableViewCell.identifier, bundle: nil)
		tableView.addSubview(refreshControl)
		return tableView
	}()

	lazy var refreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
		return refreshControl
	}()

	private var viewModel: KokoFriendListViewModel
	private var bindings = Set<AnyCancellable>()

	required init?(coder: NSCoder) {
		fatalError("this will never be called")
	}

	init(viewModel: KokoFriendListViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setupViewController()
		setupBindings()
    }

	@objc fileprivate func loadData() {
		refreshControl.beginRefreshing()
		viewModel.loadFriendList()
	}

	private func setupViewController() {
		view.addSubview(searchBar)
		view.addSubview(addFriendButton)
		view.addSubview(tableView)

		NSLayoutConstraint.activate([
			searchBar.topAnchor.constraint(equalTo: view.topAnchor),
			searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			searchBar.trailingAnchor.constraint(equalTo: addFriendButton.leadingAnchor, constant: -15),

			addFriendButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
			addFriendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			addFriendButton.widthAnchor.constraint(equalToConstant: 24),

			tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}

	private func setupBindings() {
		viewModel.$friendList.receive(on: RunLoop.main)
			.sink { [weak self] kkfriends in
				self?.tableView.reloadData()
				self?.refreshControl.endRefreshing()
			}
			.store(in: &bindings)

		viewModel.$searchedList.receive(on: RunLoop.main)
			.sink { [weak self] kkfriends in
				self?.tableView.reloadData()
			}
			.store(in: &bindings)
	}
}

extension KKSearchableFriendListViewController: UITableViewDelegate {

}

extension KKSearchableFriendListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.searchedList.isEmpty ? viewModel.friendList.count : viewModel.searchedList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendListTableViewCell.identifier, for: indexPath) as? FriendListTableViewCell else {
			return UITableViewCell()
		}
		let friendList = viewModel.searchedList.isEmpty ? viewModel.friendList : viewModel.searchedList
		cell.configure(friend: friendList[indexPath.row])
		return cell
	}
}

extension KKSearchableFriendListViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		viewModel.searchFriend(keyword: searchText)
	}
}

// Preview
struct SwiftUISearchableFriendListVC: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> KokoFriendListViewController {
		return KokoFriendListViewController()
	}

	func updateUIViewController(_ uiViewController: KokoFriendListViewController, context: Context) {
	}
}

struct SearchableFriendList_Preview: PreviewProvider {
	static var previews: some View {
		SwiftUISearchableFriendListVC()
	}
}
