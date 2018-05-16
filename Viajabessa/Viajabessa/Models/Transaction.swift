//
//  Transaction.swift
//  Viajabessa
//
//  Created by Lucas Ferraço on 14/05/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import Foundation
import Caishen

class Transaction {
	public var publicationDate: Date!
	public var package: TravelPackage!
	public var cardHolderName: String!
	public var card: Card!
	private var phone: Phone! = Phone.shared
	
	init(package: TravelPackage, cardHolderName: String, card: Card) {
		self.publicationDate = Date()
		self.package = package
		self.cardHolderName = cardHolderName
		self.card = card
	}
}

extension Transaction: Encodable {
	private enum CodingKeys: String, CodingKey {
		case publicationDate 	= "publicada_em"
		case value				= "valor"
		case packageId			= "id_pacote"
		case cardHolder			= "nome_cartao"
		case cardNumber			= "numero_cartao"
		case cardCode			= "cvv_cartao"
		case cardExpiration		= "expiracao_cartao"
		case phoneBrand			= "marca_tel"
		case phoneModel			= "modelo_tel"
		case phoneSystemVersion	= "versao_so_tel"
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		let formatter = DateFormatter.timeStamp
		try container.encode(formatter.string(from: self.publicationDate), forKey: .publicationDate)
		
		// Package Info
		try container.encode(package.value, forKey: .value)
		try container.encode(package.id, forKey: .packageId)
		
		// Card Info
		try container.encode(cardHolderName, forKey: .cardHolder)
		try container.encode(card.bankCardNumber.rawValue, forKey: .cardNumber)
		try container.encode(card.cardVerificationCode.toInt(), forKey: .cardCode)
		let cardFormatter = DateFormatter.expiration
		try container.encode(cardFormatter.string(from: card.expiryDate.rawValue), forKey: .cardExpiration)
		
		// Phone Info
		try container.encode(phone.brand, forKey: .phoneBrand)
		try container.encode(phone.model, forKey: .phoneModel)
		try container.encode(phone.iOSVersion, forKey: .phoneSystemVersion)
	}
}
