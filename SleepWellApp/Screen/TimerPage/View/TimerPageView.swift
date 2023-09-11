//
//  View.swift
//  SleepWellApp
//
//  Created by FUTURE on 2023/09/11.
//

import UIKit

class TimerPageView: UIView {
    
    // MARK: - UI 요소 & 각 요소의 속성 설정
    //타이틀 레이블
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "슬립웰 타이머"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .pastelYellow
        return label
    }()
    
    //서브 타이틀 레이블
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "정해진 시간이 되면 자동으로 앱을 종료해드려요"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .pastelYellow
        return label
    }()
    
    //타이머 머리 장식
    lazy var timerHeadView: UIView = {
        let view = UIView()
        view.backgroundColor = .pastelYellow
        view.layer.cornerRadius = 8
        return view
    }()
    
    //타이머 몸체
    lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .pastelYellow?.withAlphaComponent(0.1)
        view.layer.borderColor = UIColor.pastelYellow?.cgColor
        view.layer.borderWidth = 2.0
        view.layer.cornerRadius = 150
        return view
    }()
    
    //타이머 숫자 레이블
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 29)
        label.textAlignment = .center
        label.textColor = .pastelYellow
        label.text = "00:00:00"
        return label
    }()
    
    //시간 설정 버튼
    lazy var timeSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시간 설정", for: .normal)
        button.backgroundColor = .pastelYellow?.withAlphaComponent(1.0)
        button.setTitleColor(.indigo, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 12.5 // 알약 모양
        return button
    }()
    
    //타임 피커
    let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        return picker
    }()
    
    //시작 버튼
    lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("START", for: .normal)
        button.backgroundColor = .deepIndigo
        button.setTitleColor(.pastelYellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 17.5 // 알약 모양
        return button
    }()
    
    //멈춤 버튼
    lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("STOP", for: .normal)
        button.backgroundColor = .deepIndigo
        button.setTitleColor(.pastelYellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 17.5 // 알약 모양
        return button
    }()
    
    
    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - 뷰 추가
    private func setupView() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(timerHeadView)
        addSubview(circleView)
        addSubview(timerLabel)
        addSubview(timeSetButton)
        addSubview(startButton)
        addSubview(stopButton)
        
        setupConstraints()
    }
    
    // MARK: - 오토레이아웃
    private func setupConstraints() {
        [titleLabel, subTitleLabel, timerHeadView, circleView, timerLabel, timeSetButton, startButton, stopButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30)
        ]
        
        let subTitleLabelConstraints = [
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ]
        
        let timerHeadViewConstraints = [
            timerHeadView.widthAnchor.constraint(equalToConstant: 80),
            timerHeadView.heightAnchor.constraint(equalToConstant: 16),
            timerHeadView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerHeadView.bottomAnchor.constraint(equalTo: circleView.topAnchor, constant: -10)
        ]
        
        let circleViewConstraints = [
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 300),
            circleView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let timerLabelConstraints = [
            timerLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor)
        ]
        
        let timeSetButtonConstraints = [
            timeSetButton.widthAnchor.constraint(equalToConstant: 80),
            timeSetButton.heightAnchor.constraint(equalToConstant: 25),
            timeSetButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeSetButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 10)
        ]
        
        let startButtonConstraints = [
            startButton.widthAnchor.constraint(equalToConstant: 90),
            startButton.heightAnchor.constraint(equalToConstant: 35),
            startButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -10),
            startButton.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 30)
        ]
        
        let stopButtonConstraints = [
            stopButton.widthAnchor.constraint(equalToConstant: 90),
            stopButton.heightAnchor.constraint(equalToConstant: 35),
            stopButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            stopButton.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 30)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints + subTitleLabelConstraints + timerHeadViewConstraints + circleViewConstraints + timerLabelConstraints + timeSetButtonConstraints + startButtonConstraints + stopButtonConstraints)
    }
 
}
