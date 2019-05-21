//
//  RepositoryCell.swift
//  CodingChallange
//
//  Created by Mounir Bittar on 5/20/19.
//  Copyright © 2019 Mounir Bittar. All rights reserved.
//

import UIKit
import Kingfisher

class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var starsNbLabel: UILabel!
    @IBOutlet var indicatorView: UIActivityIndicatorView!

    var repositoryViewModel: RepositoryViewModel! {
        didSet {
            nameLabel.text = repositoryViewModel.name
            descriptionLabel.text = repositoryViewModel.description
            usernameLabel.text = repositoryViewModel.ownerUsername
            starsNbLabel.text = repositoryViewModel.stars_nb
            avatarImageView.kf.setImage(with: URL(string: repositoryViewModel.ownerAvatar), placeholder: UIImage(named: "avatar-placeholder"), options: [.transition(.fade(1)), .cacheOriginalImage])
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }

    func configure(with repository: RepositoryViewModel?) {
        if let repository = repository {
            self.repositoryViewModel = repository
            dataView.alpha = 1
            indicatorView.stopAnimating()
        } else {
            dataView.alpha = 0
            indicatorView.startAnimating()
        }
    }
}
