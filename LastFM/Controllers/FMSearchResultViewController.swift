//
//  FMSearchResultViewController.swift
//  LastFM
//
//  Created by Divyant Srivastava on 19/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import UIKit

/// View Controller to handel search result view
class FMSearchResultViewController: UIViewController {

    /// Initial view to display search message
    @IBOutlet weak var startView: UIView!

    /// table view to display search result list
    @IBOutlet weak var tableView: UITableView!

    /// activity indicator to display while fetching data from server
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    /// viewModel object to hold view related properties
    var viewModel: SearchResultViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 108.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.startView.isHidden = false
        self.viewModel = SearchResultViewModel()
        self.viewModel?.albumUpdatedClouser = {
            // Updating UI on main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }

}

extension FMSearchResultViewController: UITableViewDataSource {
   // MARK: - Table View DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.viewModel?.albums?.count ?? 0
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FMUIConstants.kSearchTableViewCell, for: indexPath) as? FMSearchItemCell else {
                return UITableViewCell()
            }
            cell.setData(viewModel: self.viewModel?.albums?[indexPath.row])
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor(red: 158.0/255, green: 132.0/255, blue: 98.0/255, alpha: 1)
            } else {
                cell.backgroundColor = UIColor.clear
            }
            return cell
        }

}

extension FMSearchResultViewController: UITableViewDelegate {
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AlbumDetail")
        if let controller =  controller as? FMAlbumDetailViewController {
            let album = self.viewModel?.albums?[indexPath.row]
            let viewModel = AlbumDetailViewModel()
            viewModel.mbidVM = album?.mbid
            controller.viewModel = viewModel
            self.navigationController?.pushViewController(controller, animated: true)
        }

    }
}

extension FMSearchResultViewController: UISearchBarDelegate {
     // MARK: - Search Bar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        self.startView.isHidden = true
        self.activityIndicator.startAnimating()
        self.viewModel?.getAlbumsForSearch(string: searchBar.text)
      }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchBar.endEditing(true)
    }
}
