//
//  WelcomeVc.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 11/28/19.
//  Copyright © 2019 Hello Tomorrow. All rights reserved.
//

import UIKit

class WelcomeVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
                navigationController?.isNavigationBarHidden = false

    }
}
