//
//  VideoCollectionViewCell.swift
//  SleepWellApp
//
//  Created by 배은서 on 2023/09/06.
//

import UIKit
import Alamofire

class VideoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "VideoCollectionViewCell"
    
    var channelName = ""
    var views = ""
    var date = ""
    
    //MARK: - UI Propertied
    
    private let thumbnailImageView: UIImageView = UIImageView()
    private let profileImageView: UIImageView = UIImageView()
    
//    private let heartButton: UIButton = {
//        var config = UIButton.Configuration.plain()
//        config.preferredSymbolConfigurationForImage = .init(font: UIFont.systemFont(ofSize: 18))
//        config.image = UIImage(systemName: "heart")
//        config.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0)
//        $0.configuration = config
//        $0.tintColor = .pastelYellow
//        return $0
//    }(UIButton())
    
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
        thumbnailImageView.backgroundColor = .deepIndigo
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        profileImageView.backgroundColor = .pastelYellow
        profileImageView.layer.cornerRadius = 15
    }
    
    private func setupLayout() {
        [thumbnailImageView, profileImageView, titleLabel, videoDescriptionLabel].forEach {
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
    
    func calculateTimeAgo(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        if let date = dateFormatter.date(from: date) {
            // 현재 시간 가져오기
            let currentDate = Date()
            
            // Calendar를 사용하여 시간 차이 계산
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: currentDate)
            
            if let years = components.year, years > 0 {
                return "\(years)년 전"
            } else if let months = components.month, months > 0 {
                return "\(months)개월 전"
            } else if let days = components.day, days > 0 {
                return "\(days)일 전"
            } else if let hours = components.hour, hours > 0 {
                return "\(hours)시간 전"
            } else if let minutes = components.minute, minutes > 0 {
                return "\(minutes)분 전"
            } else {
                return "방금 전"
            }
        } else {
            print("날짜를 파싱할 수 없습니다.")
            return ""
        }
    }
    
    static func formatCount(_ viewCount: String) -> String {
        guard let count = Int(viewCount) else { return "" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        if count >= 10000 { // 1만 이상
            let dividedCount = count / 10000
            let formattedCount = formatter.string(from: NSNumber(value: dividedCount)) ?? "\(dividedCount)"
            return "\(formattedCount)만회"
        } else if count >= 1000 { // 1천 이상
            let dividedCount = count / 1000
            let formattedCount = formatter.string(from: NSNumber(value: dividedCount)) ?? "\(dividedCount)"
            return "\(formattedCount)천회"
        } else { // 1천 미만
            return "\(count)회"
        }
    }

    
    func bind(video: Video) {
        thumbnailImageView.image = video.thumbnail.image
        thumbnailImageView.contentMode = .scaleAspectFill
        titleLabel.text = video.title
        videoDescriptionLabel.text = "\(video.channelTitle) · 조회수 \(VideoCollectionViewCell.formatCount(video.viewCount)) · \(calculateTimeAgo(date: video.publishedAt))"
    }
    
}
