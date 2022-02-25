//
//  Tracks.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import Foundation
struct Tracks : Decodable {
	let track : [Track]?

	enum CodingKeys: String, CodingKey {

		case track = "track"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		track = try values.decodeIfPresent([Track].self, forKey: .track)
	}

}

struct Track : Decodable {
    let name : String?
    let url : String?
    let duration : String?
    let streamable : Streamable?
    let artist : Artist?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case url = "url"
        case duration = "duration"
        case streamable = "streamable"
        case artist = "artist"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        streamable = try values.decodeIfPresent(Streamable.self, forKey: .streamable)
        artist = try values.decodeIfPresent(Artist.self, forKey: .artist)
    }

}
