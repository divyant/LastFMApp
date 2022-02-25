//
//  AlbumDetail.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import Foundation

struct AlbumDetail : Decodable {
	let name : String?
	let artist : String?
	let mbid : String?
	let url : String?
	let image : [Image]?
	let listeners : String?
	let playcount : String?
	let tracks : Tracks?
	let tags : Tags?
	let wiki : Wiki?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case artist = "artist"
		case mbid = "mbid"
		case url = "url"
		case image = "image"
		case listeners = "listeners"
		case playcount = "playcount"
		case tracks = "tracks"
		case tags = "tags"
		case wiki = "wiki"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		artist = try values.decodeIfPresent(String.self, forKey: .artist)
		mbid = try values.decodeIfPresent(String.self, forKey: .mbid)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		image = try values.decodeIfPresent([Image].self, forKey: .image)
		listeners = try values.decodeIfPresent(String.self, forKey: .listeners)
		playcount = try values.decodeIfPresent(String.self, forKey: .playcount)
		tracks = try values.decodeIfPresent(Tracks.self, forKey: .tracks)
		tags = try values.decodeIfPresent(Tags.self, forKey: .tags)
		wiki = try values.decodeIfPresent(Wiki.self, forKey: .wiki)
	}

}
