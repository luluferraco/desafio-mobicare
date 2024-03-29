//
//  AddCardInteractor.swift
//  Viajabessa
//
//  Created by Lucas Ferraço on 15/05/18.
//  Copyright (c) 2018 Lucas Ferraço. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Caishen

protocol AddCardBusinessLogic {
	func storeCard(_ request: AddCard.Save.Request)
}

protocol AddCardDataStore {
	var parentViewController: UIViewController! { get set }
	var creditCard: Card! { get set }
}

class AddCardInteractor: AddCardBusinessLogic, AddCardDataStore {
	var presenter: AddCardPresentationLogic?
	
	
	var parentViewController: UIViewController!
	var creditCard: Card!
	
	// MARK: Store Card
	
	func storeCard(_ request: AddCard.Save.Request) {
		self.creditCard = request.card
		let response = AddCard.Save.Response()
		presenter?.presentSavingResult(response)
	}
}
