//
//  BreatheViewController.swift
//  Refresh
//
//  Created by Austin Louden on 8/18/20.
//  Copyright © 2020 Austin Louden. All rights reserved.
//

import UIKit

final class BreatheViewController: UIViewController {

    var constraints = [NSLayoutConstraint]()
    let welcomeLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.textColor = .secondaryLabel
        l.text = NSLocalizedString("Take a few seconds to find a comfortable spot.",
                                              comment: "Tells the user to a comfortable position before starting the exercise.")
        return l
    }()

    let settingsHeaderLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .label
        l.font = UIFont.boldSystemFont(ofSize: 16)
        l.text = NSLocalizedString("Session settings",
                                   comment: "Header to show the settings for the breathing session.")
        return l
    }()

    let settingsTableView: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.allowsSelection = false
        t.isScrollEnabled = false
        t.tableFooterView = UIView(frame: .zero)
        t.register(BreatheTableViewCell.self, forCellReuseIdentifier: BreatheTableViewCell.identifier())
        return t
    }()

    let startButton: UIButton = {
        let b = UIButton(type: .custom)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle(NSLocalizedString("Begin", comment: "Button to start the breathing exercise"), for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        return b
    }()

    let editButton: UIButton = {
        let b = UIButton(type: .roundedRect)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.contentHorizontalAlignment = .trailing
        b.setTitle(NSLocalizedString("Edit", comment: "Button to edit the breathing session settings"), for: .normal)
        return b
    }()
    
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
    
        startButton.addTarget(self, action: #selector(self.startButtonPressed), for: .touchUpInside)
        startButton.layer.cornerRadius = buttonCornerRadius
        startButton.layer.backgroundColor = CGColor(srgbRed: 99.0/255.0, green: 209.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        view.addSubview(startButton)
        
        editButton.addTarget(self, action: #selector(self.editButtonPressed), for: .touchUpInside)
        view.addSubview(editButton)

        view.addSubview(welcomeLabel)
        view.addSubview(settingsHeaderLabel)

        settingsTableView.dataSource = self
        settingsTableView.delegate = self
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

