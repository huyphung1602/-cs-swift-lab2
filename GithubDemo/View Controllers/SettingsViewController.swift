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

  let languages = ["Java", "JavaScript", "Objective-C", "Python", "Ruby", "Swift"]
  var switchOn = false
  var selectedLanguage = ""

  override func viewDidLoad() {
    super.viewDidLoad()

    selectedLanguage = GithubRepoSearchSettings.sharedInstance.language
    switchOn = selectedLanguage != ""

    tableView.tableFooterView = UIView()
  }

  @IBAction func onSaveButtonTapped(sender: UIBarButtonItem) {
    let settings = GithubRepoSearchSettings.sharedInstance
    settings.minStars = minStars
    settings.language = switchOn ? selectedLanguage : ""
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
    case 1: return languages.count + 1
    default: return 0
    }
  }

  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
    header.backgroundColor = UIColor.clearColor()
    return header
  }

  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if switchOn {
      return 44
    } else {
      switch indexPath.section {
      case 0: return 44
      case 1: return indexPath.row == 0 ? 44 : 0
      default: return 0
      }
    }
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCellWithIdentifier("SliderCell", forIndexPath: indexPath) as! SliderCell
      cell.delegate = self
      return cell

    case 1:
      if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
        cell.onSwitch.on = switchOn
        cell.delegate = self
        return cell
      } else {
        let cell = tableView.dequeueReusableCellWithIdentifier("SelectCell", forIndexPath: indexPath) as! SelectCell
        let language = languages[indexPath.row - 1]
        cell.languageLabel.text = language
        cell.checkImageView.hidden = language != selectedLanguage
        return cell
      }

    default:
      return UITableViewCell()
    }
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.section == 1 {
      if indexPath.row != 0 {
        selectedLanguage = languages[indexPath.row - 1]
        tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: .None)
      }
    }
  }

}

extension SettingsViewController: SliderCellDelegate {

  func sliderCell(sliderCell: SliderCell, didUpdateSlider starValue: Int) {
    minStars = starValue
  }

}

extension SettingsViewController: SwitchCellDelegate {

  func switchCellDidSwitchChanged(switchCell: SwitchCell) {
    switchOn = switchCell.onSwitch.on
    if selectedLanguage == "" {
      selectedLanguage = languages[0]
    }
    tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: .Automatic)
  }

}
