//
//  TabBarController.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 27.03.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
    }
}
