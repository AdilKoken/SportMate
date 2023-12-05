//
//  File.swift
//  SportMateFinder
//
//  Created by Adil Köken on 22.10.20.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var userName: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var errorLabel: UILabel!
<<<<<<< HEAD
=======
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.tintColor = .label
        self.dismissKeyboard()
    }
>>>>>>> 81324ca (Initial Commit)
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        errorLabel.text = ""
    }
    
    @IBAction func login() {
        
        UserDatabase.shared.login(username: userName.text!, password: password.text!)
        
        if Logged.user.id > 0 {
            UserDefaults.standard.set(Logged.user.id, forKey: "UserID")
            
<<<<<<< HEAD
            performSegue(withIdentifier: "Login2Profile", sender: self)
=======
            self.navigationController?.popToRootViewController(animated: true)
>>>>>>> 81324ca (Initial Commit)
            errorLabel.text = ""
        }
        else {
            errorLabel.text = "the username or the password is wrong, pls try again or register"
        }
<<<<<<< HEAD
        
            }
=======
    }
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self,action:    #selector(dismissKeyboardTouchOutside))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
        }
        
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
>>>>>>> 81324ca (Initial Commit)
}
