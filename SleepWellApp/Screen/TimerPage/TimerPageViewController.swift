//
//  TimerPageViewController.swift
//  SleepWellApp
//
//  Created by FUTURE on 2023/09/06.
//

import UIKit


class TimerPageViewController: UIViewController {
    
    // MARK: - 속성
    
    private let timerPageView = TimerPageView()
    
    private var timer: Timer? //타이머 객체 저장 변수
    private var seconds: Int = 0 //시간 저장 변수
    
    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        return picker
    }()
    
    
    // MARK: - 라이프사이클
    // viewWillAppear에 다음 코드를 넣지 않으면 마이페이지 이동 로직이 꼬임.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NavigationUtil.currentViewController = self
        NavigationUtil.setupNavigationBar(for: self)
    }
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view = timerPageView
        view.backgroundColor = .indigo //배경색 설정

        
        setupButtonActions()
    }
    
    
    // MARK: - 버튼 클릭 이벤트
    private func setupButtonActions() {
        timerPageView.timeSetButton.addTarget(self, action: #selector(setTime), for: .touchUpInside)
        timerPageView.startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        timerPageView.stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
    }
    
    
    //MARK: - TimerPage 함수 모음
    //타이머 시간 설정 (시간 설정 버튼 누르면 호출됨)
    @objc private func setTime() {
        let alert = UIAlertController(title: "타이머 시간 설정", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        customView.addSubview(timePicker)
        alert.view.addSubview(customView)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.seconds = Int(self.timePicker.countDownDuration)
            self.timerPageView.timerLabel.text = self.timeString(time: TimeInterval(self.seconds))
        }
        
        alert.addAction(okAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        NSLayoutConstraint.activate([
            timePicker.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            timePicker.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10),
            timePicker.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            timePicker.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -10)
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
    
    @objc private func updateTimer() {
        if seconds < 1 {
            timer?.invalidate()
            exit(0)
        } else {
            seconds -= 1
            timerPageView.timerLabel.text = self.timeString(time: TimeInterval(self.seconds))
        }
    }
    
    private func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}
