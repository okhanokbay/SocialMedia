//
//  PostDetailViewController.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class PostDetailViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Public properties -

    var presenter: PostDetailPresenterInterface!
    private let estimatedSectionHeaderHeight: CGFloat = 80

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        presenter.viewDidLoad()
    }
}

// MARK: - PostDetailViewInterface -

extension PostDetailViewController: PostDetailViewInterface {
    func showProgressHUD() {
        showProgressHUD(on: view)
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func reloadInterface() {
        tableView.reloadData()
    }
}

// MARK: - TableView -

extension PostDetailViewController {
    func setupTableView() {
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(MultiPurposeTableViewCell.nib, forCellReuseIdentifier: MultiPurposeTableViewCell.reuseIdentifier)
    }
}

extension PostDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = presenter.item(at: indexPath.section, row: indexPath.row)
        
        // Force casted depending on this convo here: https://stackoverflow.com/questions/44168134/how-to-correct-avoid-this-force-cast
        let cell = tableView.dequeueReusableCell(withIdentifier: MultiPurposeTableViewCell.reuseIdentifier,
                                                 for: indexPath) as! MultiPurposeTableViewCell
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewModel = presenter.itemForHeader(at: section)
        
        // Force casted depending on this convo here: https://stackoverflow.com/questions/44168134/how-to-correct-avoid-this-force-cast
        let cell = tableView.dequeueReusableCell(withIdentifier: MultiPurposeTableViewCell.reuseIdentifier) as! MultiPurposeTableViewCell
        cell.configure(with: viewModel)
        return cell.contentView
    }
}

extension PostDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return estimatedSectionHeaderHeight
    }
}
