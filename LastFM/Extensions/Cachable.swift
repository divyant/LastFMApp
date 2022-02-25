//
//  Cachable.swift
//  LastFM
//
//  Created by Divyant Srivastava on 21/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import Foundation
import UIKit

typealias SuccessCompletion = (Bool) -> ()

/// chacable protocol expose api to chache image in NSCache
protocol Cachable {

    /// This method fetches image from given url and set placeholder image if request fails
    /// - Parameter URLString: url string
    /// - Parameter placeHolder: placeholder Image
    /// - Parameter completion: completion as succes or error
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?, completion: @escaping SuccessCompletion)
}

private  let imageCache = NSCache<NSString, UIImage>()

extension UIImageView: Cachable {}

extension Cachable where Self: UIImageView {

    /// This method fetches image from given url and set placeholder image if request fails
    /// - Parameter URLString: url string
    /// - Parameter placeHolder: placeholder Image
    /// - Parameter completion: completion as succes or error
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?, completion: @escaping SuccessCompletion) {

        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            DispatchQueue.main.async {
                self.image = cachedImage
                completion(true)
            }
            return
        }
        self.image = placeHolder

        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            DispatchQueue.main.async {
                                self.image = downloadedImage
                                completion(true)
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                    self.image = placeHolder
                    }
                }
            }).resume()
        } else {
            self.image = placeHolder
        }
    }
}
