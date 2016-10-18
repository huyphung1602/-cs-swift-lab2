//
//  SwitchCell.swift
//  GithubDemo
//
//  Created by Chau Vo on 7/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
  @objc optional func switchCellDidSwitchChanged(_ switchCell: SwitchCell)
}
class SwitchCell: UITableViewCell {

  @IBOutlet weak var onSwitch: UISwitch!

  weak var delegate: SwitchCellDelegate?

  @IBAction func onSwitchChanged(_ sender: UISwitch) {
    delegate?.switchCellDidSwitchChanged?(self)
  }
}
