//
//  TravelPackage.swift
//  Viajabessa
//
//  Created by Lucas Ferraço on 14/05/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

class TravelPackage: Decodable {
	public let id: Int!
	public let name: String!
	public let description: String!
	public let imageURLString: String!
	public var image: UIImage?
	public let value: Double!
	
	private enum CodingKeys: String, CodingKey {
		case id				= "id"
		case name			= "nome"
		case description	= "descricao"
		case imageURLString = "url_imagem"
		case value			= "valor"
	}
	
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(Int.self, forKey: .id)
		name = try values.decode(String.self, forKey: .name)
		description = try values.decode(String.self, forKey: .description)
		imageURLString = try values.decode(String.self, forKey: .imageURLString)
		value = try values.decode(Double.self, forKey: .value)
	}
}
