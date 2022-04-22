//
//  LogInViewController.swift
//  Navigation
//
//  Created by Ilya on 23.02.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.backgroundColor = .systemBlue
        button.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 10
        button.center = contentView.center
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var emailIsValid = false
    var passwordIsValid = false
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private let emailValidType: String.ValidTypes = .email
    private let passwordValidType: String.ValidTypes = .password
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setupView()
        self.setupConstraints()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        self.emailTextField.text = "test@test.ru"
        self.passwordTextField.text = "TEst1234"
    }
    
    private func setupView() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(stackView)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(logInButton)
        self.contentView.addSubview(messageLabel)
        
        let textFields = [emailTextField, passwordTextField]
        
        textFields.enumerated().forEach({ (index, textField) in
            textField.tintColor = .darkGray
            textField.backgroundColor = .systemGray6
            textField.font = .systemFont(ofSize: 16, weight: .regular)
            textField.textColor = .black
            textField.autocapitalizationType = .none
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
            textField.leftViewMode = .always
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.borderWidth = 0.5
            textField.returnKeyType = .continue
            textField.delegate = self
            
            switch index {
            case 0:
                textField.placeholder = "Email of phone"
                textField.keyboardType = .emailAddress
            case 1:
                textField.placeholder = "Password"
                textField.isSecureTextEntry = true
            default:
                break
            }
            
            self.stackView.addArrangedSubview(textField)
        })
    }
    
    private func setupConstraints() {
        let srollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let srollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let srollViewLeadingConstraint = self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let srollViewTrailingConstraint = self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        let contentViewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let contentViewHeightXConstraint = self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        let contentViewBottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        let contentViewWidthConstraint = self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        
        let imageViewTopConstraint = self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 120)
        let imageViewWidthConstraint = self.imageView.widthAnchor.constraint(equalToConstant: 100)
        let imageViewHeigthConstraint = self.imageView.heightAnchor.constraint(equalToConstant: 100)
        let imageViewCenterXConstraint = self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        
        let stackViewTopConstraint = self.stackView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 120)
        let stackViewTrailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let stackViewLeadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        
        let loginMessageLabelTopConstraint = self.messageLabel.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 8)
        let loginMessageLabelLeadingConstraint = self.messageLabel.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 10)
        let loginMessageLabelTrailingConstraint = self.messageLabel.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -10)
        
        let logInButtonTopConstraint = self.logInButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 56)
        let logInButtonHeightConstraint = self.logInButton.heightAnchor.constraint(equalToConstant: 50)
        let logInButtonWidthConstraint = self.logInButton.widthAnchor.constraint(equalTo: self.stackView.widthAnchor)
        let logInButtonLeadingConstraint = self.logInButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        
        NSLayoutConstraint.activate([
            srollViewTopConstraint, srollViewBottomConstraint, srollViewLeadingConstraint, srollViewTrailingConstraint, contentViewTopConstraint, contentViewHeightXConstraint, contentViewBottomConstraint, contentViewWidthConstraint, stackViewTopConstraint, stackViewTrailingConstraint, stackViewLeadingConstraint, imageViewTopConstraint, imageViewWidthConstraint, imageViewHeigthConstraint, imageViewCenterXConstraint, logInButtonHeightConstraint, logInButtonTopConstraint, logInButtonWidthConstraint, logInButtonLeadingConstraint, loginMessageLabelTopConstraint, loginMessageLabelLeadingConstraint, loginMessageLabelTrailingConstraint
        ].compactMap({ $0 }))
        
        for textField in self.stackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                textField.widthAnchor.constraint(equalTo: self.stackView.widthAnchor),
                textField.heightAnchor.constraint(equalToConstant: 50)
            ].compactMap({ $0 }))
        }
    }
    
    @objc func logInTapped() {
        
        if emailTextField.text == "test@test.ru" && passwordTextField.text == "TEst1234" {
            let alertController = UIAlertController(title: "This is an EXAMPLE of a email and password", message: "Please, enter your real email and password", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "ok", style: .default)
            alertController.addAction(okButton)
            self.present(alertController, animated: true)
        }

        if emailTextField.text == "" {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
                self.emailTextField.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
                self.view.layoutIfNeeded()
            } completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
                    self.emailTextField.backgroundColor = .systemGray6
                }
            }
            self.messageLabel.text = "Email is empty"
            return
        }

        if passwordTextField.text == "" {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
                self.passwordTextField.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
                self.view.layoutIfNeeded()
            } completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
                    self.passwordTextField.backgroundColor = .systemGray6
                    self.messageLabel.textColor = .systemRed
                }
            }
            self.messageLabel.text = "Password is empty"
            return
        }

        if emailIsValid == false || passwordIsValid == false {
            return
        }

        let profileVC = ProfileViewController()
        self.navigationController?.pushViewController(profileVC, animated: true)

        switch logInButton.state {
        case .normal:
            logInButton.alpha = 1
        case .selected:
            logInButton.alpha = 0.8
        case .highlighted:
            logInButton.alpha = 0.8
        case .disabled:
            logInButton.alpha = 0.8
        default:
            break
        }
    }
    
    @objc func adjustForKeyboard (notification: Notification){
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let contentOffset: CGPoint = notification.name == UIResponder.keyboardWillHideNotification
            ? .zero
            : CGPoint(x: 0, y: keyboardHeight / 6)
            self.scrollView.contentOffset = contentOffset
        }
    }
    
    private func setTextField(textField: UITextField, label: UILabel, validType: String.ValidTypes, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType: validType) {
            label.text = validMessage
            label.textColor = .systemGreen
            if validType == .email { emailIsValid = true }
            if validType == .password { passwordIsValid = true }
        } else {
            label.text = wrongMessage
            label.textColor = .systemRed
            if validType == .email { emailIsValid = false }
            if validType == .password { passwordIsValid = false }
        }
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case emailTextField: setTextField(textField: emailTextField,
                                          label: messageLabel,
                                          validType: emailValidType,
                                          validMessage: "Login is valid",
                                          wrongMessage: "Enter the correct login",
                                          string: string,
                                          range: range)
        case passwordTextField: setTextField(textField: passwordTextField,
                                             label: messageLabel,
                                             validType: passwordValidType,
                                             validMessage: "Password is valid",
                                             wrongMessage: "Password must contain at least 2 capital letters and 2 digits and at least 8 characters",
                                             string: string,
                                             range: range)
        default: break
        }
        
        return false
    }
}

