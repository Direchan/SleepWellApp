//
//  CustomTableViewCell.swift
//  SleepWellApp
//
//  Created by FUTURE on 2023/09/06.
//

import UIKit
import Alamofire


protocol CustomTableViewCellDelegate: AnyObject {
    func didTapHeartButton(onCell cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    private var isHeartFilled: Bool = false
    
    weak var delegate: CustomTableViewCellDelegate?
    
    private let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .pastelYellow  // 버튼 색상을 노랑색으로 설정
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .deepIndigo
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .pastelYellow
        label.font = UIFont.systemFont(ofSize: 15)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8  //행 간격 설정
        
        let attributedString = NSMutableAttributedString(string: "이 영상의 제목이 보이는 곳 어쩌구 저쩌구 글자수 제한이 영상의 제목이 보이는 곳 어쩌구 저쩌구 글자수 제한")
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        label.attributedText = attributedString
        
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "조회수 16만회"
        label.textColor = .pastelYellow?.withAlphaComponent(0.6)
        label.font = UIFont.systemFont(ofSize: 12)
        
        
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infoLabel, heartButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, infoStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(thumbnailImageView)
        cellBackgroundView.addSubview(textStackView)
        
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellBackgroundView.heightAnchor.constraint(equalToConstant: 100),
            
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            thumbnailImageView.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 8),
            thumbnailImageView.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 110),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 86),
            
            textStackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            textStackView.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 5),
            textStackView.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -10)
        ])
        heartButton.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        
    }
    
    // 하트 버튼이 눌렸을 때 호출
    @objc private func didTapHeartButton() {
        isHeartFilled.toggle()
                
            let imageName = isHeartFilled ? "heart.fill" : "heart"
            heartButton.setImage(UIImage(systemName: imageName), for: .normal)
                
            self.setNeedsLayout()
            self.layoutIfNeeded()
                
            delegate?.didTapHeartButton(onCell: self)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(video: Video) {
            thumbnailImageView.image = video.thumbnail.image
            titleLabel.text = video.title
            infoLabel.text = "조회수 \(VideoCollectionViewCell.formatCount(video.viewCount))"
            
            isHeartFilled = LikedVideosManager.shared.isLiked(video: video) // 상태 업데이트
            
            let imageName = isHeartFilled ? "heart.fill" : "heart"
            heartButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
}
