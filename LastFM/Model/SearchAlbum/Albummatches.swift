//
//  Albummatches.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//


import Foundation
struct Albummatches : Decodable {
	let album : [Album]?

	enum CodingKeys: String, CodingKey {

		case album = "album"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		album = try values.decodeIfPresent([Album].self, forKey: .album)
	}

}
