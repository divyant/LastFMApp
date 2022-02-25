//
//  FMAlbumDetailViewController.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import UIKit

/// View Controller to handle Album detail view
class FMAlbumDetailViewController: UIViewController {

    /// activity Indicator to display while fetching details from network layer
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    /// table view outlet
    @IBOutlet weak var tableView: UITableView!

    /// viewModel object to hold all view related properties
    var viewModel: AlbumDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        self.viewModel?.loadViewModelData()
        self.viewModel?.viewModelDidLoad = { (success, error) in
            if error != nil {
                DispatchQueue.main.async{
                self.showAlert(errorMessage: error)
                }
            } else {
                // Updating UI on main thread
                DispatchQueue.main.async {
                    (self.tableView.tableHeaderView as? FMAlbumDetailHeaderView)?.setData(viewModel: self.viewModel)
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.updateHeaderViewHeight()
    }

    /// This method show alert if there is any error occured while fetching data from network layer.
    /// - Parameter errorMessage: error message
    fileprivate func showAlert(errorMessage: String?) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }

}

extension FMAlbumDetailViewController: UITableViewDataSource {
   // MARK: - Table View DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.trackArray?.count ?? 0
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell : UITableViewCell!
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            }
         let trackViewModel = self.viewModel?.trackArray?[indexPath.row]
         cell.textLabel?.text = trackViewModel?.title
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor(red: 158.0/255, green: 132.0/255, blue: 98.0/255, alpha: 1)
            } else {
                cell.backgroundColor = UIColor.clear
            }
            return cell
        }

}

extension FMAlbumDetailViewController: UITableViewDelegate {
    // MARK: - Table View Delegate
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
       switch(section) {
         case 0:
            return FMUIConstants.kSectionTitle
         default :
            return ""

       }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "WebView")
        if let controller =  controller as? FMWebViewController {
            let trackViewModel = self.viewModel?.trackArray?[indexPath.row]
            controller.webViewUrl = trackViewModel?.url
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension UITableView {
    /// Method to dynamically updated the table header height.
    func updateHeaderViewHeight() {
        if let header = self.tableHeaderView {
            let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            header.frame.size.height = newSize.height
        }
    }
}
