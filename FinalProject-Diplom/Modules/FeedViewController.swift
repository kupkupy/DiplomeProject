//
//  ViewController.swift
//  Navigation
//
//  Created by Ilya on 10.02.2022.
//

import UIKit

class FeedViewController: UIViewController {

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let firstButton = UIButton()
    private let secondButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNavigationBar()
        self.setupView()
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Feed"
    }
    
    private func setupView() {
        self.view.addSubview(verticalStackView)
        
        let buttons = [firstButton, secondButton]
        buttons.enumerated().forEach({ (index, button) in
            button.layer.cornerRadius = 12
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
            switch index {
            case 0:
                button.setTitle("Open post", for: .normal)
                button.backgroundColor = .systemYellow
            case 1:
                button.setTitle("Read more", for: .normal)
                button.backgroundColor = .systemPurple
            default:
                break
            }
        })
        
        self.verticalStackView.addArrangedSubview(firstButton)
        self.verticalStackView.addArrangedSubview(secondButton)
        
        let stackViewCenterXConstraint = self.verticalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let stackViewCenterYConstraint = self.verticalStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let widthStackView = self.verticalStackView.widthAnchor.constraint(equalToConstant: 200)
        let heightFirstButton = self.firstButton.heightAnchor.constraint(equalToConstant: 60)
        
        
        NSLayoutConstraint.activate([
            stackViewCenterXConstraint, stackViewCenterYConstraint, heightFirstButton, widthStackView
        ].compactMap({ $0 }))
    }
    
    @objc func tapButton() {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
    }
}

