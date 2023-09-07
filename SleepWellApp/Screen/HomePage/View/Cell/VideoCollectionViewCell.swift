//
//  VideoCollectionViewCell.swift
//  SleepWellApp
//
//  Created by 배은서 on 2023/09/06.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "VideoCollectionViewCell"
    
    var channelName = ""
    var views = ""
    var date = ""
    
    //MARK: - UI Propertied
    
    private let thumbnailImageView: UIImageView = UIImageView()
    private let profileImageView: UIImageView = UIImageView()
    
    private let heartButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.preferredSymbolConfigurationForImage = .init(font: UIFont.systemFont(ofSize: 18))
        config.image = UIImage(systemName: "heart")
        config.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0)
        $0.configuration = config
        $0.tintColor = .pastelYellow
        return $0
    }(UIButton())
    
    private let titleLabel: UILabel = {
        $0.textColor = .pastelYellow
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        return $0
    }(UILabel())
    
    private lazy var videoDescriptionLabel: UILabel = {
        $0.text = "\(channelName) · 조회수\(views)회 · \(date)"
        $0.textColor = .pastelYellow
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        return $0
    }(UILabel())
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // cell 확인용 데이터
        titleLabel.text = "제목이다"
        channelName = "채널명"
        views = "10만"
        date = "1개월전"
        thumbnailImageView.backgroundColor = .deepIndigo
        profileImageView.backgroundColor = .pastelYellow
        
        configUI()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - InitUI
    
    private func configUI() {
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 8
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        profileImageView.layer.cornerRadius = 15
    }
    
    private func setupLayout() {
        [thumbnailImageView, profileImageView, heartButton, titleLabel, videoDescriptionLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 310)
        ])
        
        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 10),
            heartButton.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            profileImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 13),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            videoDescriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            videoDescriptionLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 13),
            videoDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            videoDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    // MARK: - Custom Method
    
    
}
