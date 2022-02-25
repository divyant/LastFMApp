//
//  Streamable.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import Foundation
struct Streamable : Decodable {
	let text : String?
	let fulltrack : String?

	enum CodingKeys: String, CodingKey {

		case text = "#text"
		case fulltrack = "fulltrack"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		fulltrack = try values.decodeIfPresent(String.self, forKey: .fulltrack)
	}

}
