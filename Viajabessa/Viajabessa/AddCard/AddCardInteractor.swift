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

protocol AddCardBusinessLogic {
	func doSomething(request: AddCard.Something.Request)
}

protocol AddCardDataStore {
	//var name: String { get set }
}

class AddCardInteractor: AddCardBusinessLogic, AddCardDataStore {
	var presenter: AddCardPresentationLogic?
	var worker: AddCardWorker?
	//var name: String = ""
	
	// MARK: Do something
	
	func doSomething(request: AddCard.Something.Request) {
		worker = AddCardWorker()
		worker?.doSomeWork()
		
		let response = AddCard.Something.Response()
		presenter?.presentSomething(response: response)
	}
}