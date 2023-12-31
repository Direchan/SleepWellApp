//
//  TimerPageViewController.swift
//  SleepWellApp
//
//  Created by FUTURE on 2023/09/06.
//

import UIKit


class TimerPageViewController: UIViewController {
    
    
    // MARK: - UI 요소 & 각 요소의 속성 설정
    //타이틀 레이블
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "슬립웰 타이머"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .pastelYellow
        return label
    }()
    
    //서브 타이틀 레이블
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "정해진 시간이 되면 자동으로 앱을 종료해드려요"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .pastelYellow
        return label
    }()
    
    //타이머 머리 장식
    private lazy var timerHeadView: UIView = {
        let view = UIView()
        view.backgroundColor = .pastelYellow
        view.layer.cornerRadius = 8
        return view
    }()
    
    //타이머 몸체
    private lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .pastelYellow?.withAlphaComponent(0.1)
        view.layer.borderColor = UIColor.pastelYellow?.cgColor
        view.layer.borderWidth = 2.0
        view.layer.cornerRadius = 150
        return view
    }()
    
    //타이머 숫자 레이블
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 29)
        label.textAlignment = .center
        label.textColor = .pastelYellow
        label.text = "00:00:00"
        return label
    }()
    
    //시간 설정 버튼
    private lazy var timeSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시간 설정", for: .normal)
        button.addTarget(self, action: #selector(setTime), for: .touchUpInside) //setTime 함수 호출
        button.backgroundColor = .pastelYellow?.withAlphaComponent(1.0)
        button.setTitleColor(.indigo, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 12.5 // 알약 모양
        return button
    }()
    
    //타임 피커
    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        return picker
    }()
    
    //시작 버튼
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("START", for: .normal)
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        button.backgroundColor = .deepIndigo
        button.setTitleColor(.pastelYellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 17.5 // 알약 모양
        return button
    }()
    
    //멈춤 버튼
    private lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("STOP", for: .normal)
        button.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        button.backgroundColor = .deepIndigo
        button.setTitleColor(.pastelYellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 17.5 // 알약 모양
        return button
    }()
    
    
    // MARK: - TimerPage 타이머 저장 변수
    private var timer: Timer? //타이머 객체 저장 변수
    private var seconds: Int = 0 //시간 저장 변수
    
    
    // MARK: - viewWillAppear
    // viewWillAppear에 다음 코드를 넣지 않으면 마이페이지 이동 로직이 꼬임.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NavigationUtil.currentViewController = self
        NavigationUtil.setupNavigationBar(for: self)
    }
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .indigo //배경색 설정
        setupConstraint()
    }
    
    
    //MARK: - TimerPage 함수 모음
    //타이머 시간 설정 (시간 설정 버튼 누르면 호출됨)
    @objc private func setTime() {
        timePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
        let alert = UIAlertController(title: "타이머 시간 설정", message: "\n\n\n\n\n\n", preferredStyle: .alert) //피커뷰랑 겹치지 않게 공백 추가
        alert.view.addSubview(timePicker)
    
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.seconds = Int(self.timePicker.countDownDuration)
            self.timerLabel.text = self.timeString(time: TimeInterval(self.seconds))
        }
        alert.addAction(okAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timePicker.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 20),
            timePicker.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -20),
            timePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50),
            timePicker.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -70) // Adjust this value to prevent overlap
        ])
        present(alert, animated: true, completion: nil)
    }
    
    
    //타이머 시간 변경될 때 호출
    @objc private func timeChanged(_ sender: UIDatePicker) {
        seconds = Int(sender.countDownDuration)
    }
    
    //타이머 시작
    @objc private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //타이머 멈춤
    @objc private func stopTimer() {
        timer?.invalidate()
    }
    
    //타이머 1초마다 업데이트
    @objc private func updateTimer() {
        if seconds < 1 {
            timer?.invalidate()
            exit(0)
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    //타이머 초를 시:분:초 형태로 변환
    private func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    // MARK: - 오토레이아웃
    private func setupConstraint() {
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(circleView)
        view.addSubview(timerHeadView)
        view.addSubview(timerLabel)
        view.addSubview(timeSetButton)
        view.addSubview(startButton)
        view.addSubview(stopButton)
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timeSetButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        circleView.translatesAutoresizingMaskIntoConstraints = false
        timerHeadView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            
            timeSetButton.widthAnchor.constraint(equalToConstant: 80),
            timeSetButton.heightAnchor.constraint(equalToConstant: 25),
            
            startButton.widthAnchor.constraint(equalToConstant: 90),
            startButton.heightAnchor.constraint(equalToConstant: 35),
            
            stopButton.widthAnchor.constraint(equalToConstant: 90),
            stopButton.heightAnchor.constraint(equalToConstant: 35),
            
            
            timerLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            timeSetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeSetButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 10),
            
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 300),
            circleView.heightAnchor.constraint(equalToConstant: 300),
            
            timerHeadView.widthAnchor.constraint(equalToConstant: 80),
            timerHeadView.heightAnchor.constraint(equalToConstant: 16),
            timerHeadView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerHeadView.bottomAnchor.constraint(equalTo: circleView.topAnchor, constant: -10),
            
            startButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            stopButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            
            startButton.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 30),
            stopButton.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 30)
        ])
    }
}
