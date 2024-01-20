//
//  KKFriendNavigationController.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/20.
//

import UIKit

class KKFriendNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
		if let rootViewController = viewControllers.first {
			setupNavigationBarItem(for: rootViewController)
		}
    }

	private func setupNavigationBarItem(for viewController: UIViewController) {
		let transferItem = BarItem.transfer.makeBarButtonItem()
		let withdrawItem = BarItem.withdraw.makeBarButtonItem()
		let scanItem = BarItem.scan.makeBarButtonItem()

		viewController.navigationItem.rightBarButtonItems = [scanItem]
		viewController.navigationItem.leftBarButtonItems = [transferItem, withdrawItem]
	}
}

extension KKFriendNavigationController {
	private enum BarItem {
		case transfer
		case withdraw
		case scan

		func makeBarButtonItem() -> UIBarButtonItem {
			let item = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
			return item
		}

		private var image: UIImage? {
			switch self {
			case .transfer: return UIImage(resource: .icNavPinkTransfer)
			case .withdraw: return UIImage(resource: .icNavPinkWithdraw)
			case .scan: return UIImage(resource: .icNavPinkScan)
			}
		}
	}
}
