//
//  ProfileViewController.swift
//  SportMateFinder
//
//  Created by Adil Köken on 04.11.20.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var LogInOut: UIBarButtonItem!
    @IBOutlet var UserName: UILabel!
    @IBOutlet var Mail: UILabel!
<<<<<<< HEAD
=======
    @IBOutlet var AgeLabel: UILabel!
>>>>>>> 81324ca (Initial Commit)
    @IBOutlet var ProfileImage: UIImageView!
    @IBOutlet var countryText: UITextField!
    @IBOutlet var stateText: UITextField!
    
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDatabase.shared.UserIdFind()
    
        if Logged.user.id > 0 { // 0 means no user has been logged in
            LogInOut.title = "Log Out"
            
<<<<<<< HEAD
=======
            countryText.isUserInteractionEnabled = true
            stateText.isUserInteractionEnabled = true
            
>>>>>>> 81324ca (Initial Commit)
            ProfileImage.isHidden = false
            UserName.text = "Username: \(Logged.user.username)"
            Mail.text = "Mail: \(Logged.user.mail)"
            
            countryLabel.text = "Country: \(Logged.user.country)"
            stateLabel.text = "State: \(Logged.user.state)"
            
<<<<<<< HEAD
            countryText.placeholder = "you can change hear"
            stateText.placeholder = "you can change hear"
=======
            countryText.placeholder = "change Country"
            stateText.placeholder = "change State"
            
            AgeLabel.text = "Your Age: \(Logged.user.age)"
            countryText.text = Logged.user.country
            loadStates()
>>>>>>> 81324ca (Initial Commit)
        }
        else {
            LogInOut.title = "Log In"
            ProfileImage.isHidden = true
<<<<<<< HEAD
=======
            countryText.isUserInteractionEnabled = false
            stateText.isUserInteractionEnabled = false
>>>>>>> 81324ca (Initial Commit)
        }
    }
        
    @IBAction func LogInOrOut() {
        if Logged.user.id > 0 {
            Logged.user.id = 0
            UserName.text = "Username:"
            Mail.text = "Mail:"
            countryText.text = ""
            stateText.text = ""
            countryLabel.text = "Country:"
            stateLabel.text = "State:"
            UserDefaults.standard.set(0, forKey: "UserID")
            LogInOut.title = "Log In"
<<<<<<< HEAD
=======
            AgeLabel.text = ""
>>>>>>> 81324ca (Initial Commit)
        }
        else {
            performSegue(withIdentifier: "LogIn", sender: self)
        }
    }
    
<<<<<<< HEAD
    
    
    
    
    //For once, when view did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Settings for UIPickerWiews
        countryText.text = Logged.user.country
=======
    //For once, when view did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Settings for UIPickerWiews
>>>>>>> 81324ca (Initial Commit)
        loadCountry()
        loadStates()
        createCountryPicker()
        createStatePicker()
<<<<<<< HEAD
=======

>>>>>>> 81324ca (Initial Commit)
    }
    
    //COUNTRY AND STATE SETTINGS
    //Country UIPickerView
    var countryPickerView = UIPickerView()
<<<<<<< HEAD
=======
    //Sport Type UIPickerView
>>>>>>> 81324ca (Initial Commit)
    func createCountryPicker() {
        countryText.inputView = countryPickerView
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryPickerView.tag = 1
<<<<<<< HEAD
    }
    
    //State UIPickerView
=======
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedCountry))
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        countryText.inputAccessoryView = toolbar
    }
    @objc func donePressedCountry() {
        countryText.resignFirstResponder()
    }
    
    //City UIPIickerView
>>>>>>> 81324ca (Initial Commit)
    var statePickerView = UIPickerView()
    func createStatePicker() {
        stateText.inputView = statePickerView
        statePickerView.delegate = self
        statePickerView.dataSource = self
        statePickerView.tag = 2
<<<<<<< HEAD
=======

                //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedState))
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        stateText.inputAccessoryView = toolbar
        
        
    }
    @objc func donePressedState() {
        stateText.resignFirstResponder()
>>>>>>> 81324ca (Initial Commit)
    }
    
    //JSON
    //Reading JSON
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    //Parsing states.json
    var states: [String] = ["--"]
    func loadStates() {
        //to reset the array, evertime a country is selected
        states.removeAll()
        states.append("--")
<<<<<<< HEAD
        stateText.text = "Select a State"
=======
>>>>>>> 81324ca (Initial Commit)
        
        guard let data = readLocalFile(forName: "states") else {
            print("Error, Reading the local data")
            return
        }
        
        var list: CountryWithStatesList?
        do {
            list = try JSONDecoder().decode(CountryWithStatesList.self, from: data)
        }
        catch let error {
            print(error)
        }
        
        guard let result = list else {
            print("Error No countries")
            return
        }

        for value in result.countries {
            if value.country == countryText.text {
                for valueS in value.states {
                    states.append(valueS)
                }
            }
        }
    }
    
    //Parsin countries.json
    var countries: [String] = ["--"]
    func loadCountry() {
<<<<<<< HEAD
    
=======
        countries.append(Logged.user.country)
>>>>>>> 81324ca (Initial Commit)
        guard let data = readLocalFile(forName: "countries") else {
            print("Error, Reading the local data")
            return
        }
        
        var list: CountryCodeList?
        do {
            list = try JSONDecoder().decode(CountryCodeList.self, from: data)
        }
        catch let error {
            print(error)
        }
        
        guard let result = list else {
            print("Error No countries")
            return
        }

        for value in result.country_list {
            countries.append(value.name)
        }
    }
}

extension ProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return countries.count
        case 2:
            return states.count
        default:
            return 1 //ERROR
        }
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return countries[row]
        case 2:
            return states[row]
        default:
            return "Not found" //ERROR
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            countryText.text = countries[row]
<<<<<<< HEAD
            countryText.resignFirstResponder()
            Logged.user.country = countries[row]
            loadStates()
            countryLabel.text = "Country: \(Logged.user.country)"
            
        case 2:
            stateText.text = states[row]
            stateText.resignFirstResponder()
=======
            Logged.user.country = countries[row]
            loadStates()
            countryLabel.text = "Country: \(Logged.user.country)"
        case 2:
            stateText.text = states[row]
>>>>>>> 81324ca (Initial Commit)
            Logged.user.state = states[row]
            stateLabel.text = "State: \(Logged.user.state)"
        default:
            return
        }
    }
}

