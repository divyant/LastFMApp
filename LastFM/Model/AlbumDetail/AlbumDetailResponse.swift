//
//  AlbumDetailResponse.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import Foundation
struct AlbumDetailResponse : Decodable {
	let album : AlbumDetail?

	enum CodingKeys: String, CodingKey {
		case album = "album"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		album = try values.decodeIfPresent(AlbumDetail.self, forKey: .album)
	}

}

struct ErrorResponse: Decodable {

    let error: Int?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        error = try values.decodeIfPresent(Int.self, forKey: .error)
    }
}
