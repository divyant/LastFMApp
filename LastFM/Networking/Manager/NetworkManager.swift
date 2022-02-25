//
//  NetworkManager.swift
//  LastFM
//
//  Created by Divyant Srivastava on 20/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import Foundation

/// Types of response i.e. success, nodata etc.
enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

/// Result enum
enum Result<String>{
    case success
    case failure(String)
}

/// Network Manager to make server request to fetch data
struct NetworkManager {

    /// API key
    static let LastFMAPIKey = "51b3c63574b28cf46aa46d628714b8db"

    /// router object
    let router = Router<LastFMApi>()

    /// Method to fetch album for serach string
    /// - Parameter searchString: search string
    /// - Parameter completion: array of albums or error if any
    func getAlbumSearchResult(searchString: String?, completion: @escaping (_ album: [Album]?,_ error: String?)->()){
        router.request(.fetchAlbumSearchData(searchString: searchString)) { data, response, error in

            if error != nil {
                completion(nil, "Please check your network connection.")
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(SearchResponse.self, from: responseData)
                        completion(apiResponse.results?.albummatches?.album,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }

    /// This method fetches album detail for specific album id
    /// - Parameter albumId: album id
    /// - Parameter completion: album detail or  eror if any
    func getAlbumDetail(albumId: String? , completion: @escaping (_ album: AlbumDetail?,_ error: String?)->()) {
        router.request(.fetchAlbumDetail(albumId: albumId)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(AlbumDetailResponse.self, from: responseData)
                        if apiResponse.album == nil {
                            let apiErrorResponse = try JSONDecoder().decode(ErrorResponse.self, from: responseData)
                            completion(nil,apiErrorResponse.message)
                        }
                        completion(apiResponse.album,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }

    /// This method  checks response sussces of failure as per response code
    /// - Parameter response: response object
    /// - Returns: Result as success or error
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
