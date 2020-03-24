//
//  AlbumDetailView.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 23/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import UIKit

final class AlbumDetailView: UIView {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(color: .standard(.themeColor))
        label.font = .init(.avenirDemiBold, size: .standard(.h4))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(color: .standard(.themeColor))
        label.font = .init(.avenirRegular, size: .standard(.h6))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(color: .standard(.themeColor))
        label.font = .init(.avenirRegular, size: .standard(.h6))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let copyrightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(color: .standard(.themeColor))
        label.font = .init(.avenirRegular, size: .standard(.h6))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(color: .standard(.themeColor))
        label.font = .init(.avenirRegular, size: .standard(.h6))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let albumArtImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let albumButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open Album", for: [])
        button.setTitleColor(.white, for: [])
        button.titleLabel?.font = .init(.avenirDemiBold, size: .standard(.h4))
        button.backgroundColor = .init(color: .standard(.themeColor))
        return button
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    private func buildViewHierarchy() {
        [mainStackView, albumButton].forEach(addSubview(_:))
        
        [albumArtImageView, nameLabel, artistLabel, releaseDateLabel, genreLabel, copyrightLabel]
            .forEach(mainStackView.addArrangedSubview(_:))
    }
    
    private func setupConstraints() {
        mainStackView.layout {
            $0.leading == leadingAnchor
            $0.trailing == trailingAnchor
            $0.top == safeAreaLayoutGuide.topAnchor
        }
        
        albumArtImageView.layout {
            $0.leading == mainStackView.leadingAnchor
            $0.trailing == mainStackView.trailingAnchor
            $0.height.equal(to: 250)
        }
        
        albumButton.layout {
            $0.leading == leadingAnchor + 20
            $0.trailing == trailingAnchor - 20
            $0.bottom == safeAreaLayoutGuide.bottomAnchor + 20
            $0.height.equal(to: 50)
        }
    }
    
    private func configureViews() {
        backgroundColor = .white
        albumArtImageView.image = #imageLiteral(resourceName: "placeholder")
    }
}
