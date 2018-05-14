//
//  PhoneInfo.swift
//  Viajabessa
//
//  Created by Lucas Ferraço on 14/05/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

class Phone {
	
	//MARK: Singleton Definition
	private static var theOnlyInstance: Phone?
	static var shared: Phone {
		get {
			if theOnlyInstance == nil {
				theOnlyInstance = Phone()
			}
			return theOnlyInstance!
		}
	}
	
	public var brand: String! {
		return "Apple"
	}
	
	public var model: String! {
		return UIDevice.current.modelName
	}
	
	public var iOSVersion: String! {
		return "iOS " + UIDevice.current.systemVersion
	}
}
