//
//  PostDetailPresenter.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class PostDetailPresenter {

    // MARK: - Private properties -

    private unowned let view: PostDetailViewInterface
    private let interactor: PostDetailInteractorInputInterface
    private let router: PostDetailRouterInterface
    private let post: PostViewModelProtocol

    private var headerViewModels: [MultiPurposeTableCellViewModelable] = []
    private var cellViewModels: [[MultiPurposeTableCellViewModelable]] = []

    // MARK: - Lifecycle -

    init(view: PostDetailViewInterface,
         interactor: PostDetailInteractorInputInterface,
         router: PostDetailRouterInterface,
         post: PostViewModelProtocol) {

        self.view = view
        self.interactor = interactor
        self.router = router
        self.post = post
    }
}

// MARK: - Extensions -

extension PostDetailPresenter: PostDetailPresenterInterface {
    func viewDidLoad() {
        DispatchQueue.main.async {
            self.view.setTitle(Strings.Post.detailTitle.rawValue)
            self.view.showProgressHUD()
        }

        setupInitialCellViewModels()

        interactor.getComments(for: post)
    }

    func numberOfSections() -> Int {
        return cellViewModels.count
    }

    func numberOfItems(in section: Int) -> Int {
        return cellViewModels[section].count
    }

    func item(at section: Int, row: Int) -> MultiPurposeTableCellViewModelable {
        return cellViewModels[section][row]
    }

    func itemForHeader(at section: Int) -> MultiPurposeTableCellViewModelable {
        return headerViewModels[section]
    }
}

// MARK: - OutputInterface -

extension PostDetailPresenter: PostDetailInteractorOutputInterface {
    func commentsReceived(comments: [CommentViewModelProtocol]) {
        makeHeader(from: comments)
        makeCells(from: comments)

        DispatchQueue.main.async {
            self.view.hideProgressHUD()
            self.view.reloadInterface()
        }
    }

    private func makeHeader(from comments: [CommentViewModelProtocol]) {
        let commentsTitle = "\(Strings.Post.commentsTitle.rawValue) (\(comments.count))"
        let commentsTitleCellViewModel = MultiPurposeTableCellViewModel(leftImage: ImageFactory.comment.image,
                                                                        firstText: commentsTitle,
                                                                        canBeSelected: false,
                                                                        isInHeader: true)
        headerViewModels.append(commentsTitleCellViewModel)
    }

    private func makeCells(from comments: [CommentViewModelProtocol]) {
        var viewModels: [MultiPurposeTableCellViewModelable] = []

        if comments.isEmpty {
            let noCommentCellViewModel = MultiPurposeTableCellViewModel(firstText: Strings.Post.noComment.rawValue)
            viewModels.append(noCommentCellViewModel)

        } else {
            let commentCellViewModels: [MultiPurposeTableCellViewModel] = comments.map { comment in
                return .init(firstText: comment.body,
                             secondText: comment.name,
                             thirdText: comment.email,
                             canBeSelected: false)
            }
            viewModels.append(contentsOf: commentCellViewModels)
        }

        cellViewModels.append(viewModels)
    }
}

// MARK: - Initial Setup Helper -

extension PostDetailPresenter {
    func setupInitialCellViewModels() {
        let authorNameCellViewModel = MultiPurposeTableCellViewModel(leftImage: ImageFactory.profile.image,
                                                                     firstText: post.name,
                                                                     canBeSelected: false,
                                                                     isInHeader: true)
        headerViewModels.append(authorNameCellViewModel)

        let postDescriptionCellViewModel = MultiPurposeTableCellViewModel(firstText: post.title,
                                                                          secondText: post.body,
                                                                          canBeSelected: false)
        cellViewModels.append([postDescriptionCellViewModel])
    }
}
