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
    let settingsHeaderLabel = UILabel()
    let settingsTableView = UITableView()
    let startButton = UIButton(type: .custom)
    let editButton = UIButton(type: .roundedRect)
    
    let sessionData = Session.sessionDataArray(Session.defaultSession())

    // Constants
    let viewMargin: CGFloat = 20
    let buttonHeight: CGFloat = 44
    let buttonCornerRadius: CGFloat = 8

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        title = NSLocalizedString("Welcome.", comment: "The title displayed on the primary screen.")
        navigationController?.navigationBar.prefersLargeTitles = true
    
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(self.startButtonPressed), for: .touchUpInside)
        startButton.setTitle(NSLocalizedString("Begin", comment: "Button to start the breathing exercise"), for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        startButton.layer.cornerRadius = buttonCornerRadius
        startButton.layer.backgroundColor = CGColor(srgbRed: 99.0/255.0, green: 209.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        view.addSubview(startButton)
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.contentHorizontalAlignment = .trailing
        editButton.addTarget(self, action: #selector(self.editButtonPressed), for: .touchUpInside)
        editButton.setTitle(NSLocalizedString("Edit", comment: "Button to edit the breathing session settings"), for: .normal)
        view.addSubview(editButton)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textColor = .secondaryLabel
        welcomeLabel.text = NSLocalizedString("Take a few seconds to find a comfortable spot.",
                                              comment: "Tells the user to a comfortable position before starting the exercise.")
        view.addSubview(welcomeLabel)
        
        settingsHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsHeaderLabel.textColor = .label
        settingsHeaderLabel.font = UIFont.boldSystemFont(ofSize: 16)
        settingsHeaderLabel.text = NSLocalizedString("Session settings",
            comment: "Header to show the settings for the breathing session.")
        view.addSubview(settingsHeaderLabel)

        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.allowsSelection = false
        settingsTableView.isScrollEnabled = false
        settingsTableView.tableFooterView = UIView(frame: .zero)
        settingsTableView.register(BreatheTableViewCell.self, forCellReuseIdentifier: BreatheTableViewCell.identifier())
        view.addSubview(settingsTableView)
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
            
            constraints.append(settingsHeaderLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20))
            constraints.append(settingsHeaderLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: viewMargin))
            constraints.append(settingsHeaderLabel.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -viewMargin))
            
            constraints.append(editButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 14))
            constraints.append(editButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -viewMargin))
            
            constraints.append(settingsTableView.topAnchor.constraint(equalTo: settingsHeaderLabel.bottomAnchor, constant: 8))
            constraints.append(settingsTableView.bottomAnchor.constraint(equalTo: startButton.topAnchor))
            constraints.append(settingsTableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor))
            constraints.append(settingsTableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor))

            NSLayoutConstraint.activate(constraints)
        }
        super.updateViewConstraints()
    }

    // MARK: Actions

    @objc func editButtonPressed() {
        self.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    @objc func startButtonPressed() {
        print("begin pressed")
    }
}

extension BreatheViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreatheTableViewCell.identifier(),
                                                 for: indexPath) as! BreatheTableViewCell
        cell.textLabel?.text = sessionData[indexPath.row]
        return cell
    }
}

