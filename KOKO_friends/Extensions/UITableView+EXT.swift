//
//  UITableView+EXT.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/19.
//

import UIKit

extension UITableView {
	func kk_registerCellWithNib(identifier: String, bundle: Bundle?) {
		let nib = UINib(nibName: identifier, bundle: bundle)
		register(nib, forCellReuseIdentifier: identifier)
	}

	func kk_registerCell<T: UITableViewCell>(_ cellType: T.Type) {
		register(cellType, forCellReuseIdentifier: T.identifier)
	}
}

extension UITableViewCell {
	static var identifier: String {
		String(describing: self)
	}
}
