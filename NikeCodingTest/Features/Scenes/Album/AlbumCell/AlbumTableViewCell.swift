//
//  AlbumTableViewCell.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 21/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import UIKit
import Combine

final class AlbumTableViewCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(color: .standard(.themeColor))
        label.font = .init(.avenirDemiBold, size: .standard(.h4))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(color: .standard(.themeColor))
        label.font = .init(.avenirRegular, size: .standard(.h6))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let albumArtImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewConfiguration()
    }
    
    // MARK: - Public Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancelImageLoading()
    }
    
    func configure(with viewModel: AlbumRowViewModel) {
        cancelImageLoading()
        nameLabel.text = viewModel.name
        artistLabel.text = viewModel.artist
        albumArtImageView.image = #imageLiteral(resourceName: "placeholder")
        cancellable = viewModel.poster.sink { [unowned self] image in self.showImage(image: image) }
    }
    
    // MARK: - Private Methods
    
    private func showImage(image: UIImage?) {
        cancelImageLoading()
        UIView.transition(with: self.albumArtImageView,
                          duration: 0.1,
                          options: [.curveEaseOut, .transitionCrossDissolve],
                          animations: {
                            self.albumArtImageView.image = image
        })
    }
    
    private func cancelImageLoading() {
        albumArtImageView.image = #imageLiteral(resourceName: "placeholder")
        cancellable?.cancel()
    }
    
    private func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    private func buildViewHierarchy() {
        contentView.addSubview(mainStackView)
        [nameLabel, artistLabel].forEach(infoStackView.addArrangedSubview(_:))
        [albumArtImageView, infoStackView].forEach(mainStackView.addArrangedSubview(_:))
    }
    
    private func setupConstraints() {
        mainStackView.layout {
            $0.leading == contentView.leadingAnchor + 8
            $0.trailing == contentView.trailingAnchor - 8
            $0.top == contentView.topAnchor + 16
            $0.bottom == contentView.bottomAnchor
        }
        
        albumArtImageView.layout {
            $0.width.equal(to: 75)
            $0.height.equal(to: 100)
        }
    }
    
    private func configureViews() {
        selectionStyle = .none
    }
}
