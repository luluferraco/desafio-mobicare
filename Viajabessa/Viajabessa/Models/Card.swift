//
//  Card.swift
//  Viajabessa
//
//  Created by Lucas Ferraço on 14/05/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import Foundation
import Caishen

struct CreditCard: CardType {
	
	// Caishen Card Configuration
	
	var name: String = "Credit Card"
	
	var CVCLength: Int = 3
	
	var identifyingDigits: Set<Int> = Set(0...9999)
	
	public let numberGrouping = [4, 4, 4, 4]
	
	public let requiresCVC = true
	
	public let requiresExpiry = true
}
