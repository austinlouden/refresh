//
//  BreatheViewController.swift
//  Refresh
//
//  Created by Austin Louden on 8/18/20.
//  Copyright © 2020 Austin Louden. All rights reserved.
//

import UIKit

class BreatheViewController: UIViewController {

    var constraints = [NSLayoutConstraint]()
    let welcomeLabel = UILabel()
    let startButton = UIButton(type: .roundedRect)

    // Constants
    let viewMargin: CGFloat = 20
    let buttonHeight: CGFloat = 44
    let buttonCornerRadius: CGFloat = 8

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        title = NSLocalizedString("Welcome.", comment: "The title displayed on the primary screen.")

        navigationController?.navigationBar.prefersLargeTitles = true
        let settingsButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(self.settingsButtonPressed))
        navigationItem.setRightBarButton(settingsButton, animated: false)
    
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(self.startButtonPressed), for: .touchUpInside)
        startButton.setTitle(NSLocalizedString("Begin", comment: "Button to start the breathing exercise"), for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        startButton.layer.cornerRadius = buttonCornerRadius
        startButton.layer.backgroundColor = CGColor(srgbRed: 99.0/255.0, green: 209.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        view.addSubview(startButton)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textColor = .secondaryLabel
        welcomeLabel.text = NSLocalizedString("Take a few seconds to find a comfortable spot.",
                                              comment: "Tells the user to a comfortable position before starting the exercise.")
        view.addSubview(welcomeLabel)
    }
    
    override func updateViewConstraints() {
        if constraints.isEmpty {
            let layoutGuide = view.safeAreaLayoutGuide
            constraints.append(startButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: viewMargin))
            constraints.append(startButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -viewMargin))
            constraints.append(startButton.heightAnchor.constraint(equalToConstant: buttonHeight))
            constraints.append(startButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -viewMargin))
            
            constraints.append(welcomeLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor))
            constraints.append(welcomeLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: viewMargin))
            constraints.append(welcomeLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -viewMargin))

            NSLayoutConstraint.activate(constraints)
        }
        super.updateViewConstraints()
    }

    // MARK: Actions

    @objc func settingsButtonPressed() {
        self.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    @objc func startButtonPressed() {
        print("begin pressed")
    }
}

