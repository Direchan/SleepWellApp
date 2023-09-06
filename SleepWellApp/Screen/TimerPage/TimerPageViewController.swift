//
//  TimerPageViewController.swift
//  SleepWellApp
//
//  Created by FUTURE on 2023/09/06.
//

import UIKit

class TimerViewController: UIViewController {
    
    // MARK: - UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "슬립웰 타이머"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .pastelYellow
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "정해진 시간이 되면 자동으로 앱을 종료해드려요"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .pastelYellow
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 29)
        label.textAlignment = .center
        label.textColor = .pastelYellow
        label.text = "00:00:00"
        return label
    }()
    
    private lazy var timeSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시간 설정", for: .normal)
        button.addTarget(self, action: #selector(setTime), for: .touchUpInside)
        button.backgroundColor = .pastelYellow?.withAlphaComponent(1.0)
        button.setTitleColor(.indigo, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 12.5 // 알약 모양
        return button
    }()
    
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
    
    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        return picker
    }()
    
    
    private lazy var timerHeadView: UIView = {
        let view = UIView()
        view.backgroundColor = .pastelYellow
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .pastelYellow?.withAlphaComponent(0.1)
        view.layer.borderColor = UIColor.pastelYellow?.cgColor
        view.layer.borderWidth = 2.0
        view.layer.cornerRadius = 150
        return view
    }()
    
    
    // MARK: - Properties
    private var timer: Timer?
    private var seconds: Int = 0
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .indigo

        
        // Set up UI elements
        setupConstraint()
    }
    
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
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
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
    
    // MARK: - Actions
    @objc private func setTime() {
        timePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
        
        let alert = UIAlertController(title: "타이머 시간 설정", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        
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
    
    
    @objc private func timeChanged(_ sender: UIDatePicker) {
        seconds = Int(sender.countDownDuration)
    }
    
    @objc private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func stopTimer() {
        timer?.invalidate()
    }
    
    // MARK: - Helper Functions
    @objc private func updateTimer() {
        if seconds < 1 {
            timer?.invalidate()
            // Notify user that timer has ended
            exit(0)
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    private func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}
