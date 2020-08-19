//
//  ViewController.swift
//  Refresh
//
//  Created by Austin Louden on 8/18/20.
//  Copyright © 2020 Austin Louden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        let settingsButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(self.settingsButtonPressed))
        navigationItem.setRightBarButton(settingsButton, animated: false)
    }

    // MARK: Actions
    @objc func settingsButtonPressed() {
        self.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }

}

