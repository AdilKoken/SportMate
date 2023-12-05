//
//  NotLoggedViewController.swift
//  SportMateFinder
//
//  Created by Adil Köken on 22.12.20.
//

import UIKit

class notLogged: UIViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
<<<<<<< HEAD
=======
        if Logged.user.id > 0 {
            self.navigationController?.popToRootViewController(animated: true)
        }
>>>>>>> 81324ca (Initial Commit)
    }
}
