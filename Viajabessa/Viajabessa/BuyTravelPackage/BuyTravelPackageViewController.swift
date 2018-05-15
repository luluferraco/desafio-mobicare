//
//  BuyTravelPackageViewController.swift
//  Viajabessa
//
//  Created by Lucas Ferraço on 14/05/18.
//  Copyright (c) 2018 Lucas Ferraço. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol BuyTravelPackageDisplayLogic: class {
	func displayPackageInfo(_ viewModel: BuyTravelPackage.DisplayPackageInfo.ViewModel)
}

class BuyTravelPackageViewController: UIViewController, BuyTravelPackageDisplayLogic {
	var interactor: BuyTravelPackageBusinessLogic?
	var router: (NSObjectProtocol & BuyTravelPackageRoutingLogic & BuyTravelPackageDataPassing)?
	
	@IBOutlet weak var locationImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var descriptionTextView: UITextView!
	
	private var initialHeightForTextView: CGFloat!
	@IBOutlet var descriptionTextViewHeightConstraint: NSLayoutConstraint!
	@IBOutlet var contentViewHeightConstraint: NSLayoutConstraint!
	
	// MARK: Object lifecycle
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	// MARK: Setup
	
	private func setup() {
		let viewController = self
		let interactor = BuyTravelPackageInteractor()
		let presenter = BuyTravelPackagePresenter()
		let router = BuyTravelPackageRouter()
		viewController.interactor = interactor
		viewController.router = router
		interactor.presenter = presenter
		presenter.viewController = viewController
		router.viewController = viewController
		router.dataStore = interactor
	}
	
	// MARK: Routing
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let scene = segue.identifier {
			let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
			if let router = router, router.responds(to: selector) {
				router.perform(selector, with: segue)
			}
		}
	}
	
	// MARK: View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.initialHeightForTextView = self.descriptionTextViewHeightConstraint.constant
		
		getPackageInfo()
	}
	
	// MARK: Display Package info
	
	func getPackageInfo() {
		let request = BuyTravelPackage.DisplayPackageInfo.Request()
		interactor?.getPackageInfo(request)
	}
	
	func displayPackageInfo(_ viewModel: BuyTravelPackage.DisplayPackageInfo.ViewModel) {
		self.locationImageView.image = viewModel.image
		
		self.title = viewModel.title
		self.titleLabel.text = viewModel.title
		
		self.priceLabel.text = viewModel.price
		
		self.descriptionTextView.text = viewModel.description
		self.adjustContentSize()
	}
	
	func adjustContentSize() {
		let attString = self.descriptionTextView.attributedText.boundingRect(
			with: CGSize(width: self.descriptionTextView.bounds.width, height: .greatestFiniteMagnitude),
			options: .usesLineFragmentOrigin, context: nil
		)
		self.descriptionTextViewHeightConstraint.constant = attString.size.height + 20 // padding
		
		let contentDiff = self.descriptionTextViewHeightConstraint.constant - self.initialHeightForTextView
		self.contentViewHeightConstraint.constant += contentDiff
	}
}
