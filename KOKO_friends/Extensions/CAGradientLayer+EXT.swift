//
//  CAGradientLayer+EXT.swift
//  KOKO_friends
//
//  Created by 鍾哲玄 on 2024/1/23.
//

import UIKit

extension CAGradientLayer {
	// reference: https://developer.apple.com/tutorials/app-dev-training/creating-a-gradient-background
	static func gradientLayer(colors: (beginColor: UIColor, endColor: UIColor), in frame: CGRect, orientation: GradientOrientation = .leftToRight) -> Self {
		var layer = Self()
		layer.colors = Self.colors(colors.beginColor, colors.endColor)
		layer.frame = frame
		layer.startPoint = orientation.startPoint
		layer.endPoint = orientation.endPoint
		return layer
	}

	private static func colors(_ beginColor: UIColor, _ endColor: UIColor) -> [CGColor] {
		return [beginColor.cgColor, endColor.cgColor]
	}

	enum GradientOrientation {
		case leftToRight
		case rightToLeft

		var startPoint: CGPoint {
			switch self {
			case .leftToRight: CGPoint(x: 0, y: 0.5)
			case .rightToLeft: CGPoint(x: 1, y: 0.5)
			}
		}

		var endPoint: CGPoint {
			switch self {
			case .leftToRight: CGPoint(x: 1, y: 0.5)
			case .rightToLeft: CGPoint(x: 0, y: 0.5)
			}
		}
	}
}
