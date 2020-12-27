//
//  PostTableViewCell.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import UIKit

struct PostTableCellViewModel: PostTableCellViewModelProtocol {
    let title: String
}

final class PostTableViewCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var postTitleLabel: UILabel!
    
    func configure(with viewModel: PostTableCellViewModelProtocol) {
        postTitleLabel.text = viewModel.title
    }
}
