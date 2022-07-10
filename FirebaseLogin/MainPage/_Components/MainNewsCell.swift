//
//  MainNewsCell.swift
//  FirebaseLogin
//
//  Created by Sezgin on 9.05.2022.
//

import UIKit

class MainNewsCell: UICollectionViewCell {
    
    public var titleLabel: UILabel = {
        let label = MakeProperty.makeLabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    public var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blur = UIVisualEffectView(effect: effect)
        blur.translatesAutoresizingMaskIntoConstraints = false
        return blur
    }()
    
    var newsImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "dummyImage")
        iv.clipsToBounds = true
        iv.sizeToFit()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    var publishedDate: UILabel = {
        let label = MakeProperty.makeLabel()
        label.backgroundColor = .opaqueSeparator
        label.textColor = .systemBlue
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellValues()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setImage(_ imageUrl: String) {
        newsImage.loadImageViewWithCache(imageUrl)
    }
    
    func setupCellValues() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        contentView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.black.cgColor
        
        contentView.addSubview(newsImage)
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        contentView.addSubview(publishedDate)
        NSLayoutConstraint.activate([
            publishedDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            publishedDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
        
        contentView.addSubview(blurView)
        NSLayoutConstraint.activate([
          blurView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
          blurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
          blurView.heightAnchor.constraint(equalToConstant: 45),
          blurView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])

        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

