//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Chau Vo on 7/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

@objc protocol SettingsViewControllerDelegate {
  @objc optional func settingsViewControllerDidUpdate(_ settingsViewController: SettingsViewController)
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

  @IBAction func onSaveButtonTapped(_ sender: UIBarButtonItem) {
    let settings = GithubRepoSearchSettings.sharedInstance
    settings.minStars = minStars
    settings.language = switchOn ? selectedLanguage : ""
    delegate?.settingsViewControllerDidUpdate?(self)
    dismiss(animated: true, completion: nil)
  }

  @IBAction func onCancelButtonTapped(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }

}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0: return 1
    case 1: return languages.count + 1
    default: return 0
    }
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
    header.backgroundColor = UIColor.clear
    return header
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if switchOn {
      return 44
    } else {
      switch (indexPath as NSIndexPath).section {
      case 0: return 44
      case 1: return (indexPath as NSIndexPath).row == 0 ? 44 : 0
      default: return 0
      }
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch (indexPath as NSIndexPath).section {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "SliderCell", for: indexPath) as! SliderCell
      cell.delegate = self
      return cell

    case 1:
      if (indexPath as NSIndexPath).row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
        cell.onSwitch.isOn = switchOn
        cell.delegate = self
        return cell
      } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectCell", for: indexPath) as! SelectCell
        let language = languages[(indexPath as NSIndexPath).row - 1]
        cell.languageLabel.text = language
        cell.checkImageView.isHidden = language != selectedLanguage
        return cell
      }

    default:
      return UITableViewCell()
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if (indexPath as NSIndexPath).section == 1 {
      if (indexPath as NSIndexPath).row != 0 {
        selectedLanguage = languages[(indexPath as NSIndexPath).row - 1]
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
      }
    }
  }

}

extension SettingsViewController: SliderCellDelegate {

  func sliderCell(_ sliderCell: SliderCell, didUpdateSlider starValue: Int) {
    minStars = starValue
  }

}

extension SettingsViewController: SwitchCellDelegate {

  func switchCellDidSwitchChanged(_ switchCell: SwitchCell) {
    switchOn = switchCell.onSwitch.isOn
    if selectedLanguage == "" {
      selectedLanguage = languages[0]
    }
    tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
  }

}
