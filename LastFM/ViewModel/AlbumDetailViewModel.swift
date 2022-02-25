//
//  AlbumDetailViewModel.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import Foundation

/// View model to hold tracks in album to show on albumm detail screen
struct TrackViewModel {

    /// title of album
    var title: String?

    /// url to play the album
    var url: String?
}

/// View model to hold all the bussiness logic and attributes to display album detail screen.
class AlbumDetailViewModel {

    /// clouser hold success or error of data set up
    var viewModelDidLoad: ((_ sucess: Bool, _ error: String?)-> Void)?

    /// unique resource ID
    var mbidVM: String?

    /// title of album
    var title: String?

    /// artist of album
    var artist: String?

    /// image url
    var artWorkUrl: String?

    /// summary of album as per wiki
    var summary: String?

    /// list of tracks in album
    var trackArray: [TrackViewModel]?

    /// default init
    init() {}

    /// Method to get data for album detail, fetches data from Network Layer
    func loadViewModelData() {
        //Call network manager method to fetch album detail with album Id
        NetworkManager().getAlbumDetail(albumId: self.mbidVM) { (albumDetail, error) in
            if error != nil {
                print(error ?? "")
                self.viewModelDidLoad?(false, error)
            } else if let album = albumDetail {
                self.title = album.name
                self.artist = album.artist
                self.summary = album.wiki?.summary
                self.trackArray = album.tracks?.track?.map({ (track) -> TrackViewModel in
                    return TrackViewModel(title: track.name, url: track.url)
                })
                self.artWorkUrl = album.image?.filter({ (image) -> Bool in
                    if image.size == FMUIConstants.kExtraLarge {
                        return true
                    }
                    return false
                }).first?.text
                self.viewModelDidLoad?(true, nil)
            }
        }

    }

}
