//
//  ListTravelPackagesInteractor.swift
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

protocol ListTravelPackagesBusinessLogic {
	func getAllTravelPackages(_ request: ListTravelPackages.ListTravelPackages.Request)
	func storeSelectedTravelPackage(_ request: ListTravelPackages.StoreSelectedTravelPackage.Request)
}

protocol ListTravelPackagesDataStore {
	var selectedTravelPackage: TravelPackage? { get set }
}

class ListTravelPackagesInteractor: ListTravelPackagesBusinessLogic, ListTravelPackagesDataStore {
	var presenter: ListTravelPackagesPresentationLogic?
	let worker = ViajabessaAPIWorker.shared
	
	var selectedTravelPackage: TravelPackage?
	
	// MARK: Get all Travel Packages
	
	var allTravelPackages: [TravelPackage] = []
	
	func getAllTravelPackages(_ request: ListTravelPackages.ListTravelPackages.Request) {
		var response = ListTravelPackages.ListTravelPackages.Response(packages: nil, error: nil)
		
		worker.getAllTravelPackages { (allTravelPackages, error) in
			if let allTravelPackages = allTravelPackages {
				self.allTravelPackages = allTravelPackages
				response.packages = self.allTravelPackages
			} else if let error = error {
				response.error = error
			} else {
				response.error = .Unknown
			}
			
			self.presenter?.presentTravelPackages(response)
		}
	}
	
	// MARK: Store selected Travel Package
	
	func storeSelectedTravelPackage(_ request: ListTravelPackages.StoreSelectedTravelPackage.Request) {
		var response = ListTravelPackages.StoreSelectedTravelPackage.Response(success: false)
		
		if let selectedTravelPackage = self.allTravelPackages.first(where: { (pack) -> Bool in
			return pack.id == request.packageInfo.id
		}) {
			self.selectedTravelPackage = selectedTravelPackage
			response.success = true
		}
		
		self.presenter?.presentStoreResult(response)
	}
}
