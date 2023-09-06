//
//  HomePageViewController.swift
//  SleepWellApp
//
//  Created by t2023-m0091 on 2023/09/04.
//

import UIKit

class HomePageViewController: UIViewController {
    
    private enum Const {
        static let itemSize = CGSize(width: 320, height: 240)
        static let itemSpacing = 10.0
        
        static var insetX: CGFloat {
            (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
        }
        static var collectionViewContentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
        }
    }
    
    // MARK: - Properties
    
    
    
    //MARK: - UI Properties
    
    private let logoImageView: UIImageView = {
        $0.image = UIImage(named: "Logo")
        return $0
    }(UIImageView())
    
    private let myProfileButton: UIButton = {
        $0.tintColor = .pastelYellow
        var config = UIButton.Configuration.plain()
        config.preferredSymbolConfigurationForImage = .init(font: UIFont.systemFont(ofSize: 20))
        config.image = UIImage(systemName: "person.fill")
        $0.configuration = config
        return $0
    }(UIButton())
    
    private let messageLabel: UILabel = {
        $0.text = "힘내조님의 숙면을 위한"
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
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .horizontal
        $0.itemSize = Const.itemSize
        $0.minimumLineSpacing = Const.itemSpacing // 양 옆 간격
        $0.minimumInteritemSpacing = 0 // 위아래 간격
        return $0
    }(UICollectionViewFlowLayout())
    
    private lazy var asmrCollectionView: UICollectionView = {
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        setupCollectionView()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .indigo
    }
    
    private func setupLayout() {
        [logoImageView, myProfileButton, messageLabel, recommendedVideoLabel, asmrCollectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            myProfileButton.topAnchor.constraint(equalTo: logoImageView.topAnchor, constant: -5),
            myProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 25),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            recommendedVideoLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 5),
            recommendedVideoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            asmrCollectionView.topAnchor.constraint(equalTo: recommendedVideoLabel.bottomAnchor, constant: 15),
            asmrCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            asmrCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            asmrCollectionView.heightAnchor.constraint(equalToConstant: Const.itemSize.height)
        ])
    }
    
    private func setupCollectionView() {
        asmrCollectionView.delegate = self
        asmrCollectionView.dataSource = self
        asmrCollectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        asmrCollectionView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Custom Method
    
}

//MARK: - UICollectionViewDataSource

extension HomePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = asmrCollectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as? VideoCollectionViewCell
        else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegate

extension HomePageViewController: UICollectionViewDelegate {
    
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

