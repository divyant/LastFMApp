//
//  Album.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//


import Foundation

struct Album : Decodable {
	let name : String?
	let artist : String?
	let url : String?
	let image : [Image]?
	let streamable : String?
	let mbid : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case artist = "artist"
		case url = "url"
		case image = "image"
		case streamable = "streamable"
		case mbid = "mbid"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		artist = try values.decodeIfPresent(String.self, forKey: .artist)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		image = try values.decodeIfPresent([Image].self, forKey: .image)
		streamable = try values.decodeIfPresent(String.self, forKey: .streamable)
		mbid = try values.decodeIfPresent(String.self, forKey: .mbid)
	}

}
