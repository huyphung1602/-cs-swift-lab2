//
//  GithubCell.swift
//  GithubDemo
//
//  Created by Chau Vo on 7/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking

class GithubCell: UITableViewCell {

  @IBOutlet weak var repoName: UILabel!
  @IBOutlet weak var starLabel: UILabel!
  @IBOutlet weak var forkLabel: UILabel!
  @IBOutlet weak var ownerLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!

  var repo: GithubRepo! {
    didSet {
      repoName.text = repo.name
      starLabel.text = "\(repo.stars)"
      forkLabel.text = "\(repo.forks)"
      ownerLabel.text = repo.ownerHandle
      descriptionLabel.text = repo.repoDescription
      if let url = NSURL(string: repo.ownerAvatarURL) {
        avatarImageView.setImageWithURL(url)
      }
    }
  }

}
