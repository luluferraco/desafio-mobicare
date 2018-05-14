//
//  ListTravelPackagesModels.swift
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

enum ListTravelPackages {
	// MARK: Use cases
	
	enum ListTravelPackages {
		struct Request {}
		
		struct Response {
			var packages: [TravelPackage]?
			var error: ViajabessaAPIError?
		}
		
		struct ViewModel {
			var packagesInfo: [PackageInfo]?
			var errorMessage: String?
		}
	}
	
	struct PackageInfo {
		var name: String
		var price: String
		var image: UIImage
	}
}
