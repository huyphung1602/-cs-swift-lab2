//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Chau Vo on 7/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

@objc protocol SettingsViewControllerDelegate {
  optional func settingsViewControllerDidUpdate(settingsViewController: SettingsViewController)
}

class SettingsViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  weak var delegate: SettingsViewControllerDelegate?
  var minStars = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.tableFooterView = UIView()
  }

  @IBAction func onSaveButtonTapped(sender: UIBarButtonItem) {
    GithubRepoSearchSettings.sharedInstance.minStars = minStars
    delegate?.settingsViewControllerDidUpdate?(self)
    dismissViewControllerAnimated(true, completion: nil)
  }

  @IBAction func onCancelButtonTapped(sender: UIBarButtonItem) {
    dismissViewControllerAnimated(true, completion: nil)
  }

}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0: return 1
    default: return 0
    }
  }

  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
    header.backgroundColor = UIColor.clearColor()
    return header
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCellWithIdentifier("SliderCell", forIndexPath: indexPath) as! SliderCell
      cell.delegate = self
      return cell
    default:
      return UITableViewCell()
    }
  }

}

extension SettingsViewController: SliderCellDelegate {

  func sliderCell(sliderCell: SliderCell, didUpdateSlider starValue: Int) {
    minStars = starValue
  }

}
