//
//  FMSearchItemCell.swift
//  LastFM
//
//  Created by Divyant Srivastava on 21/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import UIKit

/// Custom cell class to display search result items.
class FMSearchItemCell: UITableViewCell {

    /// Image of search result item
    @IBOutlet weak var itemImage: UIImageView!

    /// subTitle label for search result item
    @IBOutlet weak var itemSubtitle: UILabel!

    /// Title for search result item
    @IBOutlet weak var itemTitle: UILabel!

    /// activity indicator to display over imageView while loading image
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// This method set data to cell properties
    /// - Parameter viewModel: object of cellViewModel
    func setData(viewModel: SearchItemCellViewModel?) {
        self.itemTitle.text = viewModel?.title
        self.itemSubtitle.text = viewModel?.subTitle
        self.activityIndicator.startAnimating()
        //Load Image form server
        self.itemImage.loadImageUsingCacheWithURLString(viewModel?.imageUrl ?? "", placeHolder: UIImage(named: "Avtar")) { (bool) in
            self.activityIndicator.stopAnimating()
        }
    }

}
