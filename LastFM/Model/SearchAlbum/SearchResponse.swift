//
//  SearchResponse.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//


import Foundation

struct SearchResponse : Decodable {
	let results : Results?

	enum CodingKeys: String, CodingKey {

		case results = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		results = try values.decodeIfPresent(Results.self, forKey: .results)
	}

}
