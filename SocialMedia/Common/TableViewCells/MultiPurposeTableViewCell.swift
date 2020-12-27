//
//  MultiPurposeTableViewCell.swift
//  Trainer
//
//  Created by Okhan Okbay on 27.12.2020.
//

import UIKit

enum DisclosureIndicatorType {
    case normal, arrow
}

protocol MultiPurposeTableCellViewModelable {
    var leftImage: UIImage? { get }
    var firstText: String { get }
    var secondText: String? { get }
    var thirdText: String? { get }
    var disclosureIndicatorType: DisclosureIndicatorType? { get }
}

extension MultiPurposeTableCellViewModelable {
    var leftImage: UIImage? { return nil }
    var secondText: String? {  return nil  }
    var thirdText: String? { return nil  }
    var disclosureIndicatorType: DisclosureIndicatorType? { return nil  }
}

struct MultiPurposeTableCellViewModel: MultiPurposeTableCellViewModelable {
    var leftImage: UIImage?
    let firstText: String
    var secondText: String?
    var thirdText: String?
    let disclosureIndicatorType: DisclosureIndicatorType?
}

final class MultiPurposeTableViewCell: UITableViewCell {
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var leftImageView: UIImageView!
    @IBOutlet private weak var textContainerView: UIView!
    @IBOutlet private weak var textStackView: UIStackView!
    
    @IBOutlet private weak var firstLabel: UILabel!
    @IBOutlet private weak var secondLabel: UILabel!
    @IBOutlet private weak var thirdLabel: UILabel!
    
    @IBOutlet private weak var rightContainerView: UIView!
    @IBOutlet private weak var rightImageView: UIImageView!
    
    func configure(with viewModel: MultiPurposeTableCellViewModelable) {
        setupLeftImage(with: viewModel)
        setupLabels(with: viewModel)
        setupRightView(with: viewModel)
    }
    
    private func setupLeftImage(with viewModel: MultiPurposeTableCellViewModelable) {
        if let leftImage = viewModel.leftImage {
            leftImageView.image = leftImage
            imageContainerView.isHidden = false
            
        } else {
            imageContainerView.isHidden = true
        }
    }
    
    private func setupLabels(with viewModel: MultiPurposeTableCellViewModelable) {
        firstLabel.text = viewModel.firstText
        
        secondLabel.text = viewModel.secondText
        secondLabel.isHidden = viewModel.secondText == nil
        
        thirdLabel.text = viewModel.thirdText
        thirdLabel.isHidden = viewModel.thirdText == nil
    }
    
    private func setupRightView(with viewModel: MultiPurposeTableCellViewModelable) {
        if let indicatorType = viewModel.disclosureIndicatorType {
            
            switch indicatorType {
            case .normal:
                rightImageView.image = UIImage(named: ImageName.disclosureIndicator.rawValue)
            
            case .arrow:
                rightImageView.image = UIImage(named: ImageName.rightArrow.rawValue)
            }
            
            rightContainerView.isHidden = false
        } else {
            rightContainerView.isHidden = true
        }
    }
}
