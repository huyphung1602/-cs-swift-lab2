//
//  SliderCell.swift
//  GithubDemo
//
//  Created by Chau Vo on 7/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

@objc protocol SliderCellDelegate {
  optional func sliderCell(sliderCell: SliderCell, didUpdateSlider starValue: Int)
}

class SliderCell: UITableViewCell {

  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var starLabel: UILabel!

  weak var delegate: SliderCellDelegate?

  override func awakeFromNib() {
    super.awakeFromNib()
    let starValue = GithubRepoSearchSettings.sharedInstance.minStars
    slider.value = Float(starValue)
    starLabel.text = "\(starValue)"
  }

  @IBAction func onSliderChanged(sender: UISlider) {
    let value = Int(slider.value)
    starLabel.text = "\(value)"
    delegate?.sliderCell?(self, didUpdateSlider: value)
  }

}
