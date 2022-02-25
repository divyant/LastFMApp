//
//  FMAlbumDetailHeaderView.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import UIKit

/// Header View Class to show Album details
class FMAlbumDetailHeaderView: UIView {

    /// Album artwork
    @IBOutlet weak var topImage: UIImageView!

    /// Title label to dispaly title of album
    @IBOutlet weak var titleLabel: UILabel!

    /// artistlabel to display artist name of album
    @IBOutlet weak var artistLabel: UILabel!

    /// summary label to display summary of album
    @IBOutlet weak var summaryLabel: UILabel!


    /// Set data to outlets from viewModel
    /// - Parameter viewModel: viewModel Object
    func setData(viewModel: AlbumDetailViewModel?)  {
        self.titleLabel.text = viewModel?.title
        self.artistLabel.text = viewModel?.artist
        self.summaryLabel.text = viewModel?.summary
        // Set image using url from server
        self.topImage.loadImageUsingCacheWithURLString(viewModel?.artWorkUrl ?? "", placeHolder: UIImage(named: "Avtar")) { (bool) in
        }
    }

}
