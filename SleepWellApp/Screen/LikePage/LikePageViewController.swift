//
//  LikePageViewController.swift
//  SleepWellApp
//
//  Created by t2023-m0091 on 2023/09/04.
//

import UIKit

class LikePageViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "찜 목록"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .pastelYellow
        return label
    }()
    
    
    private lazy var countListLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .pastelYellow?.withAlphaComponent(0.6)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var emptyListLabel: UILabel = {
            let label = UILabel()
            label.text = "아직 찜 목록이 없습니다 ! \n 홈으로 가서 마음에 드는 영상을 찜해보세요 :)"
            label.numberOfLines = 0
            label.textAlignment = .center
        label.textColor = .pastelYellow?.withAlphaComponent(0.5)
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.isHidden = false  // 초기에는 숨겨둡니다.
            return label
        }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NavigationUtil.currentViewController = self
        NavigationUtil.setupNavigationBar(for: self)
        setupEmptyListLabel()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .indigo
        tableView.delegate = self
        tableView.dataSource = self
        setupConstraint()
        NotificationCenter.default.addObserver(self, selector: #selector(handleLikedVideosUpdated), name: Notification.Name("LikedVideosUpdated"), object: nil)
        setupEmptyListLabel()
        
        
    }
    
    
    
    
    @objc private func handleLikedVideosUpdated() {
        tableView.reloadData()
               
               let count = LikedVideosManager.shared.likedVideos.count
               countListLabel.text = "\(count)개"
               emptyListLabel.isHidden = count > 0
    }
    
    private func setupEmptyListLabel() {
           view.addSubview(emptyListLabel)
           emptyListLabel.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               emptyListLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               emptyListLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               emptyListLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
               emptyListLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
           ])
       }
    
    private func setupConstraint() {
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        view.addSubview(countListLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countListLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        emptyListLabel.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countListLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            
            countListLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    
            
        ])
    }
}




extension LikePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LikedVideosManager.shared.likedVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        let video = LikedVideosManager.shared.likedVideos[indexPath.row]
        cell.bind(video: video)
        cell.delegate = self
        return cell
    }
}


extension LikePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    //셀 누르면 해당 영상 디테일 페이지 열리도록
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = LikedVideosManager.shared.likedVideos[indexPath.row]
        let detailVC = DetailPageViewController()
        detailVC.selectedVideo = video
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension LikePageViewController: CustomTableViewCellDelegate {
    func didTapHeartButton(onCell cell: CustomTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let video = LikedVideosManager.shared.likedVideos[indexPath.row]
        
        if LikedVideosManager.shared.isLiked(video: video) {
            LikedVideosManager.shared.remove(video: video)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else {
            LikedVideosManager.shared.add(video: video)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        // 찜하기 개수 업데이트
        let count = LikedVideosManager.shared.likedVideos.count
        countListLabel.text = "\(count)개"
    }
}
