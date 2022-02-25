//
//  Results.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import Foundation
struct Results : Decodable {
	let opensearch_Query : Opensearch_Query?
	let opensearch_totalResults : String?
	let opensearch_startIndex : String?
	let opensearch_itemsPerPage : String?
	let albummatches : Albummatches?

	enum CodingKeys: String, CodingKey {

		case opensearch_Query = "opensearch:Query"
		case opensearch_totalResults = "opensearch:totalResults"
		case opensearch_startIndex = "opensearch:startIndex"
		case opensearch_itemsPerPage = "opensearch:itemsPerPage"
		case albummatches = "albummatches"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		opensearch_Query = try values.decodeIfPresent(Opensearch_Query.self, forKey: .opensearch_Query)
		opensearch_totalResults = try values.decodeIfPresent(String.self, forKey: .opensearch_totalResults)
		opensearch_startIndex = try values.decodeIfPresent(String.self, forKey: .opensearch_startIndex)
		opensearch_itemsPerPage = try values.decodeIfPresent(String.self, forKey: .opensearch_itemsPerPage)
		albummatches = try values.decodeIfPresent(Albummatches.self, forKey: .albummatches)
	}

}
