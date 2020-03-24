//
//  AlbumDetailViewController.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 23/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import UIKit
import Combine

final class AlbumDetailViewController: UIViewController {
    private var cancellable: [AnyCancellable] = []
    private let appear = PassthroughSubject<Void, Never>()
    
    private let viewModel: AlbumDetailViewModel
    private lazy var albumDetailView = AlbumDetailView()
    
    // MARK: - Init
    
    init(viewModel: AlbumDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Controller LifeCyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appear.send(())
    }
    
    override func loadView() {
        super.loadView()
        view = albumDetailView
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        title = "Album Detail"
        albumDetailView.nameLabel.text = viewModel.name
        albumDetailView.artistLabel.text = viewModel.artist
        albumDetailView.releaseDateLabel.text = viewModel.releaseDate
        albumDetailView.copyrightLabel.text = viewModel.copyright
        albumDetailView.genreLabel.text = viewModel.genres
        albumDetailView.albumButton.addTarget(viewModel, action: #selector(viewModel.openAlbumDidTap), for: .touchUpInside)
        viewModel.artURL.sink(receiveValue: {[weak self] image in
            self?.albumDetailView.albumArtImageView.image = image
        }).store(in: &cancellable)
    }
}
