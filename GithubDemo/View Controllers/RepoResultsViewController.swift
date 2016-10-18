//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  var searchBar: UISearchBar!
  var searchSettings = GithubRepoSearchSettings()

  var repos = [GithubRepo]()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Initialize the UISearchBar
    searchBar = UISearchBar()
    searchBar.delegate = self

    // Add SearchBar to the NavigationBar
    searchBar.sizeToFit()
    navigationItem.titleView = searchBar

    tableView.estimatedRowHeight = 120
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.tableFooterView = UIView()

    // Perform the first search when the view controller first loads
    doSearch()
  }

  // Perform the search.
  fileprivate func doSearch() {
    GithubRepoSearchSettings.sharedInstance.searchString = searchBar.text

    MBProgressHUD.showAdded(to: self.view, animated: true)

    // Perform request to GitHub API to get the list of repositories
    GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

      // Print the returned repositories to the output window
      for repo in newRepos {
        print(repo)
      }
      self.repos.removeAll()
      self.repos.append(contentsOf: newRepos)
      self.tableView.reloadData()

      MBProgressHUD.hide(for: self.view, animated: true)
      }, error: { (error) -> Void in
        print(error)
    })
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ResultsToSettings" {
      if let nvc = segue.destination as? UINavigationController, let settingsVC = nvc.topViewController as? SettingsViewController {
        settingsVC.delegate = self
      }
    }
  }

}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(true, animated: true)
    return true
  }

  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(false, animated: true)
    return true
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = ""
    searchBar.resignFirstResponder()
    doSearch()
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchSettings.searchString = searchBar.text
    searchBar.resignFirstResponder()
    doSearch()
  }
}

extension RepoResultsViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repos.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GithubCell", for: indexPath) as! GithubCell
    cell.repo = repos[(indexPath as NSIndexPath).row]
    return cell
  }

}

extension RepoResultsViewController: SettingsViewControllerDelegate {

  func settingsViewControllerDidUpdate(_ settingsViewController: SettingsViewController) {
    doSearch()
  }

}
