//
//  Image.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import Foundation
struct Image : Decodable {
	let text : String?
	let size : String?

	enum CodingKeys: String, CodingKey {

		case text = "#text"
		case size = "size"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		size = try values.decodeIfPresent(String.self, forKey: .size)
	}

}
