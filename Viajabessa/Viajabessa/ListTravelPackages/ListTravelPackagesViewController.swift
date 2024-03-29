//
//  ListTravelPackagesViewController.swift
//  Viajabessa
//
//  Created by Lucas Ferraço on 13/05/18.
//  Copyright (c) 2018 Lucas Ferraço. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Reachability

protocol ListTravelPackagesDisplayLogic: class {
	func displayListOfPackages(_ viewModel: ListTravelPackages.ListTravelPackages.ViewModel)
	func displaySelectedPackageResult(_ viewModel: ListTravelPackages.StoreSelectedTravelPackage.ViewModel)
}

class ListTravelPackagesViewController: UITableViewController, ListTravelPackagesDisplayLogic {
	var interactor: ListTravelPackagesBusinessLogic?
	var router: (NSObjectProtocol & ListTravelPackagesRoutingLogic & ListTravelPackagesDataPassing)?
	
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
		let interactor = ListTravelPackagesInteractor()
		let presenter = ListTravelPackagesPresenter()
		let router = ListTravelPackagesRouter()
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
		
		self.actIndicator = CustomActIndicator(frame: self.view.bounds)
		
		self.noPacksLabel = UILabel(frame: self.view.bounds)
		self.noPacksLabel.text = "Ocorreu um erro inesperado, desculpe pelo transtorno."
		self.noPacksLabel.numberOfLines = 0
		self.noPacksLabel.textAlignment = .center
		
		self.disableRefreshIfConnected()
		self.getTravelPackages()
	}
	
	@IBOutlet weak var reloadButton: UIBarButtonItem!
	
	func disableRefreshIfConnected() {
		let reachability = Reachability()
		
		reachability?.whenUnreachable = { _ in
			self.reloadButton.isEnabled = false
		}
		
		reachability?.whenReachable = { _ in
			self.reloadButton.isEnabled = true
		}
		
		do {
			try reachability?.startNotifier()
		} catch {
			print("# Unable to start notifier")
		}
	}
	
	// MARK: List Travel Packages
	
	private var travelPackages: [ListTravelPackages.PackageInfo]! = []
	private var actIndicator: CustomActIndicator!
	private var noPacksLabel: UILabel!
	
	func getTravelPackages() {
		self.actIndicator.show(on: self.view)
		
		let request = ListTravelPackages.ListTravelPackages.Request()
		interactor?.getAllTravelPackages(request)
	}
	
	func displayListOfPackages(_ viewModel: ListTravelPackages.ListTravelPackages.ViewModel) {
		self.actIndicator.hide()
		
		if let packagesInfo = viewModel.packagesInfo {
			self.travelPackages = packagesInfo
			self.tableView.reloadData()
		} else if let message = viewModel.errorMessage {
			let alert = UIAlertController(title: "Ops", message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
			
			self.present(alert, animated: true, completion: nil)
		}
		
		if viewModel.packagesInfo == nil || viewModel.packagesInfo?.isEmpty ?? false {
			// Show no packages label
			self.view.addSubview(self.noPacksLabel)
		} else {
			self.noPacksLabel.removeFromSuperview()
		}
	}
	
	// MARK: Store selected Travel Packages
	func storeSelected(travelPackage: ListTravelPackages.PackageInfo) {
		self.actIndicator.show(on: self.view)
		
		let request = ListTravelPackages.StoreSelectedTravelPackage.Request(packageInfo: travelPackage)
		interactor?.storeSelectedTravelPackage(request)
	}
	
	func displaySelectedPackageResult(_ viewModel: ListTravelPackages.StoreSelectedTravelPackage.ViewModel) {
		self.actIndicator.hide()
		
		if viewModel.success {
			self.router?.routeToBuyTravelPackage()
		} else if let message = viewModel.errorMessage {
			let alert = UIAlertController(title: "Ops", message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
			
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	@IBAction func reloadList(_ sender: Any) {
		self.getTravelPackages()
	}
}

extension ListTravelPackagesViewController {
	
	// MARK: UITableViewDataSource implementation
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.travelPackages.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "PackageTableViewCell", for: indexPath) as? PackageTableViewCell {
			let packageForIndex = self.travelPackages[indexPath.row]
			
			cell.backgroundImageView.image = packageForIndex.image
			cell.titleLabel.text = packageForIndex.name
			cell.priceLabel.text = packageForIndex.price
			
			return cell
		}
		
		return UITableViewCell()
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200.0
	}
	
	// MARK:- UITableViewDelegate implementation
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.storeSelected(travelPackage: self.travelPackages[indexPath.row])
	}
}
