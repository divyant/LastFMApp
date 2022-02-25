//
//  LastFMEndPoint.swift
//  LastFM
//
//  Created by Divyant Srivastava on 20/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import Foundation

/// Enum(list) of apis used in application
public enum LastFMApi {
    // fetch search data
    case fetchAlbumSearchData(searchString: String?)
    // fetch album detail
    case fetchAlbumDetail(albumId: String?)
}

/// enum of api method names passed as parameter while making request
public enum ApiMethodName {
    // method name to search album
    static let albumSearch = "album.search"
    // method name to get album detail
    static let albumDetail = "album.getinfo"
}

/// extension of LastFMapi to adapt EndPointType
extension LastFMApi: EndPointType {

    /// holds base url string
    var environmentBaseURL : String {
        return "http://ws.audioscrobbler.com/2.0/"
    }

    /// basr url
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        return ""
    }

    /// httpMethod Type
    var httpMethod: HTTPMethod {
        return .get
    }

    /// HTTPTask for different apis
    var task: HTTPTask {
        switch self {
        case .fetchAlbumSearchData(let searchString):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["method": ApiMethodName.albumSearch,
                                                      "album": searchString ?? "",
                                                      "api_key": NetworkManager.LastFMAPIKey,
                                                      "format": "json"])

        case .fetchAlbumDetail(let albumId):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["method": ApiMethodName.albumDetail,
                                                      "mbid": albumId ?? "",
                                                      "api_key": NetworkManager.LastFMAPIKey,
                                                      "format": "json"])

        }
    }

    /// Header for request
    var headers: HTTPHeaders? {
        return nil
    }
}

