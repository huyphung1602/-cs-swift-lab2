//
//  SelectCell.swift
//  GithubDemo
//
//  Created by Chau Vo on 7/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SelectCell: UITableViewCell {

  @IBOutlet weak var languageLabel: UILabel!
  @IBOutlet weak var checkImageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    checkImageView.hidden = true
  }

}
