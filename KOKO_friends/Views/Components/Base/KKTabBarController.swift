//
//  KKTabBarController.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/20.
//

import UIKit

class KKTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		viewControllers = Tab.allCases.map { $0.makeViewController() }

		tabBar.tintColor = .kkTintColor
    }

}

extension KKTabBarController {
	private enum Tab: CaseIterable {
		case products
		case friends
		case manage
		case setting

		func makeViewController() -> UIViewController {
			let controller: UIViewController
			switch self {
			case.products:
				controller = UIStoryboard.products.instantiateInitialViewController()!
			case.friends:
				controller = UIStoryboard.friends.instantiateInitialViewController()!
			case.manage:
				controller = UIStoryboard.manage.instantiateInitialViewController()!
			case.setting:
				controller = UIStoryboard.setting.instantiateInitialViewController()!
			}

			controller.tabBarItem = makeTabBarItem()
			controller.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)
			return controller
		}

		private var image: UIImage? {
			switch self {
			case .products:
				return UIImage(resource: .icTabbarProductsOff)
			case .friends:
				return UIImage(resource: .icTabbarFriendsOn)
			case .manage:
				return UIImage(resource: .icTabbarManageOff)
			case .setting:
				return UIImage(resource: .icTabbarSettingOff)
			}
		}

		private func makeTabBarItem() -> UITabBarItem {
			return UITabBarItem(title: nil, image: image, selectedImage: image)
		}
	}
}
