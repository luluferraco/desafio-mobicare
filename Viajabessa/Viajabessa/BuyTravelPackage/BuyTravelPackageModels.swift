//
//  BuyTravelPackageModels.swift
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

enum BuyTravelPackage {
	// MARK: Use cases
	
	enum DisplayPackageInfo {
		struct Request {}
		
		struct Response {
			var title: String
			var value: Double
			var description: String
			var destination: String
			var image: UIImage
		}
		
		struct ViewModel {
			var title: String
			var price: String
			var description: String
			var destination: String
			var image: UIImage
		}
	}
	
	enum BuyPackage {
		struct Request {}
		
		struct Response {
			var error: BuyError?
		}
		
		struct ViewModel {
			var success: Bool
			var resultTitleMessage: String
			var resultMessage: String
		}
	}
	
	enum BuyError: Error {
		case NoConnection
		case Failure
	}
}
