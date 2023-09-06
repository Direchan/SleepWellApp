//
//  TimerPageViewController.swift
//  SleepWellApp
//
//  Created by FUTURE on 2023/09/06.
//

import UIKit

class TimerPageViewController: UIViewController {
    
    // MARK: - UI Elements
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48)
        label.textAlignment = .center
        label.text = "00:00:00"
        return label
    }()
    
    private lazy var timeSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시간 설정", for: .normal)
        button.addTarget(self, action: #selector(setTime), for: .touchUpInside)
        button.backgroundColor = UIColor.yellow.withAlphaComponent(1.0)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.layer.cornerRadius = 17.5 // 알약 모양
        return button
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("START", for: .normal)
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        button.backgroundColor = UIColor.blue.withAlphaComponent(1.0)
        button.setTitleColor(UIColor.yellow, for: .normal)
        button.layer.cornerRadius = 17.5 // 알약 모양
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("STOP", for: .normal)
        button.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        button.backgroundColor = UIColor.blue.withAlphaComponent(1.0)
        button.setTitleColor(UIColor.yellow, for: .normal)
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
        view.backgroundColor = UIColor.yellow.withAlphaComponent(0.4)
        view.layer.cornerRadius = 8  // half of height to make it pill-shaped
        return view
    }()
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow.withAlphaComponent(0.4)
        view.layer.borderColor = UIColor.blue.cgColor
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
        
        
        // Set up UI elements
        setupConstraint()
    }
    
    private func setupConstraint() {
        view.addSubview(circleView)
        view.addSubview(timerHeadView)
        view.addSubview(timerLabel)
        view.addSubview(timeSetButton)
        view.addSubview(startButton)
        view.addSubview(stopButton)
        
        
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timeSetButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        circleView.translatesAutoresizingMaskIntoConstraints = false
        timerHeadView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            timeSetButton.widthAnchor.constraint(equalToConstant: 100),
            timeSetButton.heightAnchor.constraint(equalToConstant: 35),
            
            startButton.widthAnchor.constraint(equalToConstant: 90),
            startButton.heightAnchor.constraint(equalToConstant: 35),
            
            stopButton.widthAnchor.constraint(equalToConstant: 90),
            stopButton.heightAnchor.constraint(equalToConstant: 35),
            
            
            // Center timerLabel within circleView
            timerLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            timeSetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeSetButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 300),
            circleView.heightAnchor.constraint(equalToConstant: 300),
            
            timerHeadView.widthAnchor.constraint(equalToConstant: 80),
            timerHeadView.heightAnchor.constraint(equalToConstant: 16),
            timerHeadView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerHeadView.bottomAnchor.constraint(equalTo: circleView.topAnchor, constant: -15),
            
            // Place startButton and stopButton next to each other
            startButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            stopButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            
            // Align these buttons vertically below the circleView
            startButton.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 20),
            stopButton.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 20)
        ])
    }
    
    // MARK: - Actions
    @objc private func setTime() {
        timePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
        
        let alert = UIAlertController(title: "Set Timer", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        
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
