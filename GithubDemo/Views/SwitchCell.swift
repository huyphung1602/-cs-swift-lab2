//
//  SwitchCell.swift
//  GithubDemo
//
//  Created by Chau Vo on 7/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
  optional func switchCellDidSwitchChanged(switchCell: SwitchCell)
}
class SwitchCell: UITableViewCell {

  @IBOutlet weak var onSwitch: UISwitch!

  weak var delegate: SwitchCellDelegate?

  @IBAction func onSwitchChanged(sender: UISwitch) {
    delegate?.switchCellDidSwitchChanged?(self)
  }
}
