//
//  attr.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import Foundation

struct attr : Decodable {
	let forKey : String?

	enum CodingKeys: String, CodingKey {

		case forKey = "for"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		forKey = try values.decodeIfPresent(String.self, forKey: .forKey)
	}

}
