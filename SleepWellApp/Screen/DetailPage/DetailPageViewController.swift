import UIKit
import youtube_ios_player_helper

class DetailPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    private var isHeartFilled: Bool = false
    private let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .pastelYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()

    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 0
        label.textColor = .pastelYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .pastelYellow?.withAlphaComponent(0.6)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .pastelYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 14 // 반지름, 이미지의 절반에 가까울수록 원형에 가까워짐
        imageView.clipsToBounds = true // cornerRadius 정도에 따라 이미지가 잘릴지 아닐지
        imageView.image = UIImage(named: "Logo") // 더미 이미지 이름 설정
        return imageView
    }()
    
    
    private let otherVideoLabel: UILabel = {
        let label = UILabel()
        label.text = "이 채널의 다른 영상"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .pastelYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let otherVideoCell: UITableView = {
        let otherVideo = UITableView()
        otherVideo.translatesAutoresizingMaskIntoConstraints = false
        otherVideo.backgroundColor = .clear
        otherVideo.separatorStyle = .none
        return otherVideo
    }()
    
    
    private let playerView: YTPlayerView = {
        let player = YTPlayerView()
        player.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    
    var selectedVideo: Video?
    var channelImage: UIImage?

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 해당 비디오가 찜 목록에 있는지 확인
        guard let video = selectedVideo else { return }
        
        if LikedVideosManager.shared.isLiked(video: video) {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI 구성
        setupUI()
        
        setupTableView()
        
        if let video = selectedVideo {
            titleLabel.text = video.title
            let formattedViewCount = formatViewCount(Int(video.viewCount) ?? 0)
            let formattedDate = formatDateToYYYYMMDD(from: video.publishedAt) ?? video.publishedAt
            descriptionLabel.text = "조회수 ・ \(formattedViewCount) ・ \(formattedDate)"
            authorLabel.text = video.channelTitle
            playerView.load(withVideoId: video.id)
        }
        
        if let channelImage = channelImage {
                profileImageView.image = channelImage
            }

    
        func setupUI() {
            view.backgroundColor = .indigo
            view.addSubview(playerView)
            view.addSubview(titleLabel)
            view.addSubview(descriptionLabel)
            view.addSubview(authorLabel)
            view.addSubview(profileImageView)
            view.addSubview(heartButton)
            setupConstraints()
        }
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5  // 5개의 셀을 반환
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110  // 셀의 높이 설정
    }
    
    func formatDateToYYYYMMDD(from dateString: String) -> String? {
        print("Received dateString: \(dateString)")  // Check the received dateString value

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        return nil
    }

//
    func setupTableView() {
        otherVideoCell.delegate = self
        otherVideoCell.dataSource = self
        otherVideoCell.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    
    func formatViewCount(_ count: Int) -> String {
        if count >= 10000 {
            return "\(count / 10000)만회"
        } else if count >= 1000 {
            return "\(count / 1000)천회"
        } else {
            return "\(count)회"
        }
    }

    
    
    @objc private func didTapHeartButton() {
        guard let video = selectedVideo else { return }

        if LikedVideosManager.shared.isLiked(video: video) {
            LikedVideosManager.shared.remove(video: video)
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            LikedVideosManager.shared.add(video: video)
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        NotificationCenter.default.post(name: Notification.Name("LikedVideosUpdated"), object: nil)
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9.0/16.0), //
            
            
            titleLabel.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            
            authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor, constant: 40),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            profileImageView.centerYAnchor.constraint(equalTo: authorLabel.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 28),
            profileImageView.heightAnchor.constraint(equalToConstant: 28),
            
            
            heartButton.centerYAnchor.constraint(equalTo: authorLabel.centerYAnchor),
            heartButton.leadingAnchor.constraint(equalTo: authorLabel.trailingAnchor, constant: 210),
            heartButton.widthAnchor.constraint(equalToConstant: 24),
            heartButton.heightAnchor.constraint(equalToConstant: 24)
            
            
//            otherVideoLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 40),
//            otherVideoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
//            otherVideoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
//
//
//            otherVideoCell.topAnchor.constraint(equalTo: otherVideoLabel.bottomAnchor, constant: 20),
//            otherVideoCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            otherVideoCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            otherVideoCell.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    
}
