//
//  BuyTravelPackageInteractor.swift
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
import Caishen

protocol BuyTravelPackageBusinessLogic {
	func getPackageInfo(_ request: BuyTravelPackage.DisplayPackageInfo.Request)
	func buyPackage(_ request: BuyTravelPackage.BuyPackage.Request)
}

protocol BuyTravelPackageDataStore {
	var selectedTravelPackage: TravelPackage! { get set }
	var creditCard: Card? { get set }
}

class BuyTravelPackageInteractor: BuyTravelPackageBusinessLogic, BuyTravelPackageDataStore {
	var presenter: BuyTravelPackagePresentationLogic?
	var worker: BuyTravelPackageWorker?
	
	var selectedTravelPackage: TravelPackage!
	var creditCard: Card?
	
	// MARK: Get Package info
	
	func getPackageInfo(_ request: BuyTravelPackage.DisplayPackageInfo.Request) {
		let response = BuyTravelPackage.DisplayPackageInfo.Response(
			title: self.selectedTravelPackage.name,
			value: self.selectedTravelPackage.value,
			description: self.selectedTravelPackage.description,
			destination: self.selectedTravelPackage.destination,
			image: self.selectedTravelPackage.image ?? #imageLiteral(resourceName: "logo")
		)
		presenter?.presentPackageInfo(response)
	}
	
	// MARK: Buy Package
	
	func buyPackage(_ request: BuyTravelPackage.BuyPackage.Request) {
		let worker = ViajabessaAPIWorker.shared
		let newCard = Card(number: Number(rawValue: "1234123412341234"), cvc: CVC(rawValue: "123"), expiry: Expiry(month: "12", year: "20")!)
		let newTransaction = Transaction(package: self.selectedTravelPackage, cardHolderName: "Lucas Ferraço", card: newCard)
		
		worker.buyPackage(with: newTransaction) { (error) in
			var response = BuyTravelPackage.BuyPackage.Response(error: nil)
			
			if let error = error {
				response.error = self.getModelError(from: error)
			}
			
			DispatchQueue.main.async {
				self.presenter?.presentBuyResult(response)
			}
		}
	}
	
	func getModelError(from apiError: ViajabessaAPIError) -> BuyTravelPackage.BuyError {
		switch apiError {
		case .NoConnection:
			return .NoConnection
		case .Failure(_), .Unknown, .CouldNotParseResponse:
			return .Failure
		}
	}
}
