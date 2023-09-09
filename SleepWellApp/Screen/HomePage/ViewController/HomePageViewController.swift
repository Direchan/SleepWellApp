//
//  HomePageViewController.swift
//  SleepWellApp
//
//  Created by t2023-m0091 on 2023/09/04.
//

import UIKit
import Alamofire

class HomePageViewController: UIViewController {
    
    private enum Const {
        static let itemSize = CGSize(width: 300, height: 220)
        static let itemSpacing = 10.0
        
        static var insetX: CGFloat {
            (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
        }
        static var collectionViewContentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
        }
    }
    
    // MARK: - Properties
    
    var asmrVideos: [Video] = []
    var sleepVideos: [Video] = []
    var halfAnHourVideos: [Video] = []
    var oneHourVideos: [Video] = []
    var twoHourVideos: [Video] = []
    var moreTimeVideos: [Video] = []
    
    var previousIndex = 0
    
    //MARK: - UI Properties
    
    private let recommendedMessageLabel: UILabel = {
        let nickname = DataManager.shared.getUser(userId: DataManager.shared.getCurrentUser() ?? "힘내조")?.nickname ?? "힘내조"
        $0.text = "\(nickname)님의 숙면을 위한"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .pastelYellow
        return $0
    }(UILabel())
    
    private let recommendedVideoLabel: UILabel = {
        $0.text = "추천 ASMR"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .pastelYellow
        return $0
    }(UILabel())
    
    private let recommendStackView: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .equalSpacing
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .horizontal
        $0.itemSize = Const.itemSize
        $0.minimumLineSpacing = Const.itemSpacing // 양 옆 간격
        $0.minimumInteritemSpacing = 0 // 위아래 간격
        return $0
    }(UICollectionViewFlowLayout())
    
    private lazy var asmrCollectionView: UICollectionView = {
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        $0.isPagingEnabled = false // 한 페이지의 넓이를 조절 할 수 없기 때문에 scrollViewWillEndDragging을 사용하여 구현
        $0.contentInsetAdjustmentBehavior = .never // 내부적으로 safe area에 의해 가려지는 것을 방지하기 위해서 자동으로 inset조정해 주는 것을 비활성화
        $0.contentInset = Const.collectionViewContentInset
        $0.decelerationRate = .fast // 스크롤이 빠르게 되도록 (페이징 애니메이션같이 보이게하기 위함)
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout))
    
    private let videoLengthDescriptionLabel: UILabel = {
        $0.text = "나의 수면패턴에 맞춘"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .pastelYellow
        return $0
    }(UILabel())
    
    private let videoLengthMessageLabel: UILabel = {
        $0.text = "영상 길이별 둘러보기"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .pastelYellow
        return $0
    }(UILabel())
    
    private let videoLengthStackView: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .equalSpacing
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    private lazy var segmentedControl: UISegmentedControl = {
        $0.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        return $0
    }(VideoLengthSegmentedControl(items: ["30분", "1시간", "2시간", "그 이상"]))
    
    private lazy var videoLengthTableView: UITableView = {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UITableView())
    
    // Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        setupCollectionView()
        requestVideo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationUtil.currentViewController = self
        NavigationUtil.setupNavigationBar(for: self)
    }
    
    // InitUI
    
    private func configUI() {
        view.backgroundColor = .indigo
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.pastelYellow  ?? UIColor(),
                .font: UIFont.systemFont(ofSize: 13, weight: .bold)
            ],
            for: .selected
        )
        segmentedControl.selectedSegmentIndex = 0
    }
    
    private func setupLayout() {
        [recommendStackView, asmrCollectionView, videoLengthStackView, segmentedControl, videoLengthTableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [recommendedMessageLabel, recommendedVideoLabel].forEach {
            recommendStackView.addArrangedSubview($0)
        }
        
        [videoLengthDescriptionLabel, videoLengthMessageLabel].forEach {
            videoLengthStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            recommendStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            recommendStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            asmrCollectionView.topAnchor.constraint(equalTo: recommendedVideoLabel.bottomAnchor, constant: 15),
            asmrCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            asmrCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            asmrCollectionView.heightAnchor.constraint(equalToConstant: Const.itemSize.height),
            
            videoLengthStackView.topAnchor.constraint(equalTo: asmrCollectionView.bottomAnchor, constant: 25),
            videoLengthStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            segmentedControl.topAnchor.constraint(equalTo: videoLengthStackView.bottomAnchor, constant: 13),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),
            
            videoLengthTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 5),
            videoLengthTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoLengthTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            videoLengthTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupCollectionView() {
        asmrCollectionView.delegate = self
        asmrCollectionView.dataSource = self
        asmrCollectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        asmrCollectionView.showsVerticalScrollIndicator = false
    }
    
    //MARK: - @objc
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0, 1, 2, 3:
            videoLengthTableView.reloadData()
        default:
            break
        }
    }
    
    //
    
}



extension HomePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return asmrVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = asmrCollectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as? VideoCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.bind(video: asmrVideos[indexPath.item])
        
        return cell
    }
}


extension HomePageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = asmrVideos[indexPath.item]
        
        let detailVC = DetailPageViewController()
        detailVC.selectedVideo = video
        navigationController?.pushViewController(detailVC, animated: true)
    }
}



extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
}

//MARK: - UITableViewDataSource

extension HomePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return halfAnHourVideos.count
        case 1:
            return oneHourVideos.count
        case 2:
            return twoHourVideos.count
        case 3:
            return moreTimeVideos.count
        default:
            return sleepVideos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = videoLengthTableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as? CustomTableViewCell
        else { return UITableViewCell() }
        
        cell.bind(video: sleepVideos[indexPath.row])
        
        return cell
    }
}


extension HomePageViewController: UITableViewDelegate {

}


extension HomePageViewController {
    func requestVideo() {
        getVideos(searchKeyword: "에이에스엠알", maxResults: 5) { video, index in
            self.asmrVideos.append(video)
            
            self.getVideoInfo(id: video.id, index: index) { duration, viewCount in
                
                if let duration = duration {
                    self.asmrVideos[index].duration = duration
                }
                
                if let viewCount = viewCount {
                    self.asmrVideos[index].viewCount = viewCount
                }
                
                DispatchQueue.main.async {
                    self.asmrCollectionView.reloadData()
                }
            }
            
            self.requestImage(thumbnailUrl: video.thumbnail.url) { image in
                self.asmrVideos[index].thumbnail.image = image
            }
        }
        getVideos(searchKeyword: "수면", maxResults: 5) { video, index in
            self.sleepVideos.append(video)
            self.getVideoInfo(id: video.id, index: index) { duration, viewCount in
                if let duration = duration {
                    self.sleepVideos[index].duration = duration
                }
                
                if let viewCount = viewCount {
                    self.sleepVideos[index].viewCount = viewCount
                }
                
                DispatchQueue.main.async {
                    self.videoLengthTableView.reloadData()
                }
            }
            
            self.requestImage(thumbnailUrl: video.thumbnail.url) { image in
                self.sleepVideos[index].thumbnail.image = image
            }
        }
    }
    
    func getVideos(searchKeyword: String, maxResults: Int, completion: @escaping ((_ video: Video, _ index: Int) -> ())) {
        // items.id.videoId / items.snippet.publishedAt, title / items.snippet.thumbnails / items.snippet.channelTitle
        APIManager.shared.getVideos(searchKeyword: searchKeyword, maxResults: maxResults) { data, error in
            if let data = data, let items = data["items"] as? [[String:Any]] {
                for (index, item) in items.enumerated() {
                    if let id = item["id"] as? [String:Any],
                       let videoId = id["videoId"] as? String,
                       let snippet = item["snippet"] as? [String:Any],
                       let title = snippet["title"] as? String,
                       let thumbnails = snippet["thumbnails"] as? [String:Any],
                       let standard = thumbnails["default"] as? [String:Any],
                       let thumbnailUrl = standard["url"] as? String,
                       let width = standard["width"] as? Int,
                       let height = standard["height"] as? Int,
                       let publishedAt = snippet["publishedAt"] as? String,
                       let channelTitle = snippet["channelTitle"] as? String {
                        
                        completion(Video(id: videoId,
                                         thumbnail: Thumbnail(url: thumbnailUrl, image: nil, width: width, height: height),
                                         title: title,
                                         channelTitle: channelTitle,
                                         publishedAt: publishedAt,
                                         viewCount: "",
                                         duration: ""),
                                    index)                    }
                }
            }
        }
    }
    
    func getVideoInfo(id: String, index: Int, completion: @escaping((_ duration: String?, _ viewCount: String?) -> ())) {
        
        // 영상 길이
        APIManager.shared.getVideoInfo(id: id, part: "contentDetails") { data, error in
            if let data = data, let items = data["items"] as? [[String:Any]] {
                for item in items {
                    if let content = item["contentDetails"] as? [String:Any],
                       let duration = content["duration"] as? String {
                        completion(duration, nil)
                    }
                }
            }
        }
        
        // 조회수
        APIManager.shared.getVideoInfo(id: id, part: "statistics") { data, error in
            if let data = data, let items = data["items"] as? [[String:Any]] {
                for item in items {
                    if let statistics = item["statistics"] as? [String:Any],
                       let viewCount = statistics["viewCount"] as? String {
                        completion(nil, viewCount)
                    }
                }
            }
        }
    }
    
    func requestImage(thumbnailUrl: String, completion: @escaping ((_ image: UIImage) -> ())) {
        AF.request(thumbnailUrl).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(image)
                } else {
                    print("Failed to convert data to UIImage")
                }
            case .failure(let error):
                print("Image download error: \(error)")
            }
        }
    }
}

