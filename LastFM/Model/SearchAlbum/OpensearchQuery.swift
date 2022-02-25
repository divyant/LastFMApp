//
//  Opensearch_Query.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//



import Foundation
struct Opensearch_Query : Codable {
	let text : String?
	let role : String?
	let searchTerms : String?
	let startPage : String?

	enum CodingKeys: String, CodingKey {

		case text = "#text"
		case role = "role"
		case searchTerms = "searchTerms"
		case startPage = "startPage"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		role = try values.decodeIfPresent(String.self, forKey: .role)
		searchTerms = try values.decodeIfPresent(String.self, forKey: .searchTerms)
		startPage = try values.decodeIfPresent(String.self, forKey: .startPage)
	}

}
