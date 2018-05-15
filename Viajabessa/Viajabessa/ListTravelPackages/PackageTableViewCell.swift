//
//  PackageTableViewCell.swift
//  Viajabessa
//
//  Created by Lucas Ferraço on 13/05/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

class PackageTableViewCell: UITableViewCell {

	@IBOutlet weak var backgroundImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	
	private var gradientLayer: CAGradientLayer!
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		self.backgroundImageView.layer.cornerRadius = 5.0
		self.backgroundImageView.layer.masksToBounds = true
		
		self.backgroundImageView.layer.shadowColor = UIColor.lightGray.cgColor
		self.backgroundImageView.layer.shadowRadius = 2.0
		self.backgroundImageView.layer.shadowOpacity = 1.0
		self.backgroundImageView.layer.shadowOffset = CGSize(width:0, height: 2)
		self.backgroundImageView.layer.shadowPath = UIBezierPath(rect: self.backgroundImageView.bounds).cgPath
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		// Add black layer to highlight the labels
		if self.gradientLayer == nil {
			self.gradientLayer = CAGradientLayer()
			self.gradientLayer.frame = self.backgroundImageView.bounds
			self.gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
			self.gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
			self.backgroundImageView.layer.addSublayer(self.gradientLayer)
		}
	}
}
