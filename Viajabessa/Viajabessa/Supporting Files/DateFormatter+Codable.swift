//
//  DateFormatter+Codable.swift
//  Viajabessa
//
//  Created by Lucas Ferraço on 14/05/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import Foundation

extension DateFormatter {
	static let timeStamp: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd-MM-yyyy'T'hh:mm:ss"
		return formatter
	}()
	
	static let expiration: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM/yy"
		return formatter
	}()
}
