//
//  RegistrationViewController.swift
//  SportMateFinder
//
//  Created by Adil Köken on 21.10.20.
//

import UIKit

class RegistrationViewController: UIViewController {
    @IBOutlet var mailText: UITextField!
    @IBOutlet var userNameText: UITextField!
    @IBOutlet var passWordText: UITextField!
    @IBOutlet var passWordConfirmationText: UITextField!
    @IBOutlet var ageText: UITextField!
    @IBOutlet var countryText: UITextField!
    @IBOutlet var stateText: UITextField!
    
    @IBOutlet var checkLabel: UILabel!
    
    
    // BUTTON TO REGISTER
    @IBAction func register() {
        
        while requieredFillCheck() == false {
            return
        }
        
        
<<<<<<< HEAD
        let user = User(id: 0, mail: mailText.text!, username: userNameText.text!, password: passWordText.text!, age: Int16(ageText.text!)!, country: countryText.text!, state: stateText.text!)
        
        Logged.user = UserDatabase.shared.register(user: user)
=======
        let user = User(id: 0, mail: mailText.text!, username: userNameText.text!, password: passWordText.text!, age: Int(agePicker.date.timeIntervalSince1970), country: countryText.text!, state: stateText.text!)
        
        UserDatabase.shared.register(user: user)
>>>>>>> 81324ca (Initial Commit)
        //ATTENTION
        print(String(Logged.user.id))
        
        if Logged.user.id > 0 {
<<<<<<< HEAD
            performSegue(withIdentifier: "Register2Profile", sender: self)
=======
            self.navigationController?.popToRootViewController(animated: true)
            UserDefaults.standard.set(Logged.user.id, forKey: "UserID")
>>>>>>> 81324ca (Initial Commit)
        }
    }
    
    
<<<<<<< HEAD
    var countryPickerView = UIPickerView()
    var statePickerView = UIPickerView()
=======
    
>>>>>>> 81324ca (Initial Commit)
    
    //For once, when view did Load
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        // Settings for UIPickerWiews
        loadCountry()
        
        countryText.placeholder = "Select Country"
        stateText.placeholder = "Select Country first"
        
        countryText.inputView = countryPickerView
        stateText.inputView = statePickerView
        
        countryPickerView.delegate = self
        statePickerView.delegate = self
        
        countryPickerView.dataSource = self
        statePickerView.dataSource = self
        
        countryPickerView.tag = 1
        statePickerView.tag = 2
=======
        self.navigationItem.backBarButtonItem?.tintColor = .label
        // Settings for UIPickerWiews
        loadCountry()
        createCountryPicker()
        createStatePicker()
        createAgePicker()
        
        self.dismissKeyboard()
>>>>>>> 81324ca (Initial Commit)
    }
    
    //VIEW WILL APPEAR: First settings
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
<<<<<<< HEAD
        
        
=======
>>>>>>> 81324ca (Initial Commit)
        //unloading the data
        checkLabel.text = ""
    
        passWordText.text = ""
        passWordConfirmationText.text = ""
<<<<<<< HEAD
        
        
    }
=======
    }
    
    var agePicker = UIDatePicker()
    func createAgePicker() {
        ageText.placeholder = "Birth Date"
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedTime))
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        ageText.inputAccessoryView = toolbar
        
        //assing timePicker
        ageText.inputView = agePicker
        
        //time picker mode
        agePicker.datePickerMode = .date
        agePicker.preferredDatePickerStyle = .wheels
    }
    @objc func donePressedTime() {
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        
        //assignment
        ageText.text = formatter.string(from: agePicker.date)
        self.view.endEditing(true)
    }
    
    var countryPickerView = UIPickerView()
    //Sport Type UIPickerView
    func createCountryPicker() {
        countryText.placeholder = "Select Country"
        countryText.inputView = countryPickerView
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryPickerView.tag = 1
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
    var statePickerView = UIPickerView()
    func createStatePicker() {
        stateText.placeholder = "Select Country first"
        stateText.inputView = statePickerView
        statePickerView.delegate = self
        statePickerView.dataSource = self
        statePickerView.tag = 2
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
    }
    
>>>>>>> 81324ca (Initial Commit)
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
    //DECODING states.json
<<<<<<< HEAD
    var states: [String] = ["--"]
=======
    var states: [String] = []
>>>>>>> 81324ca (Initial Commit)
    func loadstates() {
        //to reset the array, evertime a country is selected
        states.removeAll()
        states.append("--")
        stateText.placeholder = "Select a State"
        
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
    
    //DECODING countries.json
    var countries: [String] = ["--"]
    func loadCountry() {
    
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
    
    // CHECK BEFORE REGISTER
    func requieredFillCheck() -> Bool {
<<<<<<< HEAD
        guard let ageRe = Int(ageText.text!) else {
            checkLabel.text = "enter a valid age"
            return false
        }
        if ageRe < 15 {
=======
        let birthDate = agePicker.date
        let today = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: birthDate, to: today)

        if components.year ?? 0 < 15 {
>>>>>>> 81324ca (Initial Commit)
            checkLabel.text = "you must be at least 15 to register"
            return false
        }
        checkLabel.text = ""
        
        let mailRe = mailText.text
        if mailRe!.count < 4 || mailRe?.contains("@") == false {
            checkLabel.text = "enter a valid mail adress"
            return false
        }
        checkLabel.text = ""
        
        let countryRe = countryText.text
        if countryRe!.count < 2 {
            checkLabel.text = "please select a country"
            return false
        }
        checkLabel.text = ""
        
        let stateRe = stateText.text
        if stateRe!.count < 2 {
            checkLabel.text = "please select a state"
            return false
        }
        checkLabel.text = ""
        
        let userNameRe = userNameText.text
        if userNameRe!.count < 1 {
            checkLabel.text = "enter a valid user name"
            return false
        }
        if UserDatabase.shared.userNameCheck(username: userNameRe!) {
            checkLabel.text = "this username is already taken"
            return false
        }
        
        let passWordRe = passWordText.text
        let passWordConfirmation = passWordConfirmationText.text
        if passWordRe!.count < 8 {
            checkLabel.text = "password must be at least 8 charachters"
            return false
        }
        if passWordRe != passWordConfirmation {
            checkLabel.text = "PassWords are not matching"
            return false
        }
        checkLabel.text = ""
        return true
    }
    
<<<<<<< HEAD
=======
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

extension RegistrationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
=======
>>>>>>> 81324ca (Initial Commit)
            loadstates()
            Logged.user.country = countries[row]
        case 2:
            stateText.text = states[row]
<<<<<<< HEAD
            stateText.resignFirstResponder()
=======
>>>>>>> 81324ca (Initial Commit)
            Logged.user.state = states[row]
        default:
            return
        }
    }
}
