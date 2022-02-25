//
//  SearchItemCellViewModel.swift
//  LastFM
//
//  Created by Divyant Srivastava on 21/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import Foundation

/// View Model struct for seacr table view
struct SearchItemCellViewModel {

    /// title of album
    var title: String?

    /// artist of album
    var subTitle: String?

    /// thumbnail image for album
    var imageUrl: String?

    /// unique resource if for album
    var mbid: String?

    /// default init
    init() {

    }
}
