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
        label.text = "좋아요 목록"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .pastelYellow
        return label
    }()
    
    
    private lazy var countListLabel: UILabel = {
        let label = UILabel()
        label.text = "n개"
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .indigo
        tableView.delegate = self
        tableView.dataSource = self
        
        setupConstraint()
    }
    
    
    private func setupConstraint() {
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        view.addSubview(countListLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countListLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
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
        return 10 // 예시로 10개의 셀을 표시
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        return cell
    }
}

// MARK: - TableView Delegate

extension LikePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 // 셀의 높이를 100으로 설정
    }
}
