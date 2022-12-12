//
//  ViewController.swift
//  AnimationLoaderImageView
//
//  Created by Vadlet on 12.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var goButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Download and pressset", for: .normal)
        button.backgroundColor = .orange
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var customImageView = CustomImageView(frame: .zero)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    @objc private func goButtonTapped() {
        
    }
    
    private func setupConstraints() {
        view.addSubview(goButton)
        view.addSubview(customImageView)
        
        NSLayoutConstraint.activate([
            goButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            goButton.heightAnchor.constraint(equalToConstant: 60),
            
            customImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            customImageView.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
}

