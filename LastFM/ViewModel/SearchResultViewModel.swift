//
//  SearchResultViewModel.swift
//  LastFM
//
//  Created by Divyant Srivastava on 21/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import Foundation

/// This view model class hold all the bussiness logic and view required attributes to load search result screen
class SearchResultViewModel {

    /// data updation closure, fired whenever there is change in data model
    var albumUpdatedClouser: (()-> Void)?

    /// var to hold array of albums
    var albums: [SearchItemCellViewModel]? {
        didSet {
            albumUpdatedClouser?()
        }
    }

    /// default init
    init() {}

    /// This method fetches search result from Network layer for given search string
    /// - Parameter string: serach string
    func getAlbumsForSearch(string: String?)  {
        NetworkManager().getAlbumSearchResult(searchString: string) { (albums, error) in
            if error != nil {
                print(error ?? "")
            } else if let albums = albums {
                var tempAlbum: [SearchItemCellViewModel]? = [SearchItemCellViewModel]()
                for albumItem in albums {
                    var album = SearchItemCellViewModel()
                    album.title = albumItem.name
                    album.subTitle = albumItem.artist
                    album.mbid = albumItem.mbid
                    album.imageUrl = albumItem.image?.filter({ (image) -> Bool in
                        if image.size == FMUIConstants.kMediumArtWork {
                            return true
                        }
                        return false
                    }).first?.text
                    tempAlbum?.append(album)
                }
                self.albums = tempAlbum
            }
        }
    }

}
