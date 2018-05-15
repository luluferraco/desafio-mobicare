//
//  ListTravelPackagesPresenter.swift
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

protocol ListTravelPackagesPresentationLogic {
	func presentTravelPackages(_ response: ListTravelPackages.ListTravelPackages.Response)
	func presentStoreResult(_ response: ListTravelPackages.StoreSelectedTravelPackage.Response)
}

class ListTravelPackagesPresenter: ListTravelPackagesPresentationLogic {
	weak var viewController: ListTravelPackagesDisplayLogic?
	
	// MARK: Present Travel Packages
	
	func presentTravelPackages(_ response: ListTravelPackages.ListTravelPackages.Response) {
		var packagesInfo: [ListTravelPackages.PackageInfo]? = nil
		var errorMessage: String? = nil
		
		if let packagesModel = response.packages {
			packagesInfo = packagesModel.map({ (modelPackage) -> ListTravelPackages.PackageInfo in
				return ListTravelPackages.PackageInfo(
					id: modelPackage.id,
					name: modelPackage.name,
					price: "R$" + modelPackage.value.toString,
					image: modelPackage.image ?? #imageLiteral(resourceName: "logo.png")
				)
			})
		} else if let error = response.error {
			errorMessage = self.message(for: error)
		} else {
			errorMessage = self.message(for: .Unknown)
		}
		
		let viewModel = ListTravelPackages.ListTravelPackages.ViewModel(packagesInfo: packagesInfo, errorMessage: errorMessage)
		viewController?.displayListOfPackages(viewModel)
	}
	
	private func message(for apiError: ViajabessaAPIError) -> String {
		switch apiError {
		case .NoConnection:
			return "Sem conexão com a internet."
		case .CouldNotParseResponse:
			return "Ocorreu um erro, entre em contato com a equipe Viajabessa."
		case .Failure(let message):
			return "Ocorreu um erro: \(message)."
		case .Unknown:
			return "Ocorreu um erro desconhecido. Por favor, tente novamente mais tarde"
		}
	}
	
	// MARK: Present store result
	
	func presentStoreResult(_ response: ListTravelPackages.StoreSelectedTravelPackage.Response) {
		var viewModel = ListTravelPackages.StoreSelectedTravelPackage.ViewModel(success: response.success, errorMessage: nil)
		
		if !viewModel.success {
			viewModel.errorMessage = "Ocorreu um erro ao abrir pacote, tente novamente mais tarde."
		}
		
		self.viewController?.displaySelectedPackageResult(viewModel)
	}
}
