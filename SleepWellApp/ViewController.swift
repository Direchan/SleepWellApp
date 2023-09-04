import UIKit

class ViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Title Here"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First placeholder"
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 0)) // Placeholder for icon
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let secondTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Second placeholder"
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 0)) // Placeholder for icon
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Button Text", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray6
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(firstTextField)
        view.addSubview(secondTextField)
        view.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            firstTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            firstTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            firstTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            firstTextField.heightAnchor.constraint(equalToConstant: 50),
            
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 10),
            secondTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            secondTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            secondTextField.heightAnchor.constraint(equalToConstant: 50),
            
            button.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
