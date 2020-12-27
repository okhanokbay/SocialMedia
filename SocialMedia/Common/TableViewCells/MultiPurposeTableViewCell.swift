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
    var canBeSelected: Bool { get }
    var isInHeader: Bool { get }
}

extension MultiPurposeTableCellViewModelable {
    var leftImage: UIImage? { return nil }
    var secondText: String? {  return nil  }
    var thirdText: String? { return nil  }
    var disclosureIndicatorType: DisclosureIndicatorType? { return nil  }
    var canBeSelected: Bool { return true }
    var isInHeader: Bool { return false }
}

struct MultiPurposeTableCellViewModel: MultiPurposeTableCellViewModelable {
    var leftImage: UIImage?
    let firstText: String
    var secondText: String?
    var thirdText: String?
    var disclosureIndicatorType: DisclosureIndicatorType?
    var canBeSelected: Bool = true
    var isInHeader: Bool = false
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
    
    private var viewModel: MultiPurposeTableCellViewModelable!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if viewModel.canBeSelected {
            setBackgroundColor(for: highlighted)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if viewModel.canBeSelected {
            setBackgroundColor(for: selected)
        }
    }
    
    private func setBackgroundColor(for activeStatus: Bool) {
        contentView.backgroundColor = activeStatus ? .systemYellow : (viewModel.isInHeader ? .systemGray5 : .systemGray6)
    }
    
    func configure(with viewModel: MultiPurposeTableCellViewModelable) {
        self.viewModel = viewModel
        
        setBackgroundColor(for: false)
        
        setupLeftImage(with: viewModel)
        setupLabels(with: viewModel)
        setupRightView(with: viewModel)
    }
}

// MARK: - Helpers -

extension MultiPurposeTableViewCell {
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
                rightImageView.image = ImageFactory.disclosureIndicator.image
            
            case .arrow:
                rightImageView.image = ImageFactory.rightArrow.image
            }
            
            rightContainerView.isHidden = false
        } else {
            rightContainerView.isHidden = true
        }
    }
}
