//
//  CreateViewController.swift
//  SportMateFinder
//
//  Created by Adil Köken on 08.11.20.
//

<<<<<<< HEAD
import Foundation
=======
import UIKit

class CreateViewController: UIViewController {
    @IBOutlet var HeadlineTextField: UITextField!
    @IBOutlet var SportTypeTextField: UITextField!
    @IBOutlet var LocationTextField: UITextField!
    @IBOutlet var CityTextField: UITextField!
    @IBOutlet var maxPlayerTextField: UITextField!
    @IBOutlet var minAgeTextField: UITextField!
    @IBOutlet var maxAgeTextField: UITextField!
    @IBOutlet var timeTextField: UITextField!
    @IBOutlet var succesUIView: UIView!
    @IBOutlet var succesBtnView: UIButton!
    
    @IBOutlet var FillmentLabel: UILabel!
    
    
    @IBAction func createButton() {
        
        if fillingCheck() == false {
            return
        }
        let headline = HeadlineTextField.text!
        let type = SportTypeTextField.text!
        let location = LocationTextField.text!
        let city = CityTextField.text!
        let maxPlayer = Int(maxPlayerTextField.text!)!
        let maxAge = Int(maxAgeTextField.text!)!
        let minAge = Int(minAgeTextField.text!)!
        let time = Int(timePicker.date.timeIntervalSince1970)
        
        let EventId = EventDatabase.shared.createEvent(headLine: headline, type: type, maxPlayerCount: maxPlayer, currentPlayerCount: 0, city: city, locationAdress: location, ageMin: minAge, ageMax: maxAge, time: time)
        EventDatabase.shared.assignUser(eventID: EventId, time: time)
        
        succesUIView.isHidden = false
        clean()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDatabase.shared.UserIdFind()

        succesView()
        //FOR UIPickerViews
        CityTextField.placeholder = "Select City"
        createCityPicker()
        createDatePicker()
        createSportTypePicker()
        self.dismissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //check if a user logged id
        if Logged.user.id < 1 {
            performSegue(withIdentifier: "notLogged", sender: nil)
            return
        }
        
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        FillmentLabel.text = ""
        loadCities()
        SportTypeTextField.placeholder = "Select Type"
    }
    
    //TO Clean aftet the event is created
    func clean() {
        HeadlineTextField.text = ""
        SportTypeTextField.text = ""
        LocationTextField.text = ""
        maxPlayerTextField.text = ""
        minAgeTextField.text = ""
        maxAgeTextField.text = ""
        timeTextField.text = ""
    }
    
    // DESING FUNCTIONS
    //for succes UIView
    func succesView() {
        succesUIView.isHidden = true
        succesUIView.layer.cornerRadius = 8.0
        succesBtnView.layer.cornerRadius = 8.0
    }
    
    @IBAction func succesBtn() {
        succesUIView.isHidden = true
    }
    
    //PICKERVIEW FUNCTIONS
    var sportTypePickerView = UIPickerView()
    var cityPickerView = UIPickerView()
    var timePicker = UIDatePicker()
    
    //Date UIPickerView
    func createDatePicker() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedTime))
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        timeTextField.inputAccessoryView = toolbar
        
        //assing timePicker
        timeTextField.inputView = timePicker
        
        //time picker mode
        timePicker.datePickerMode = .dateAndTime
        timePicker.preferredDatePickerStyle = .wheels
    }
    @objc func donePressedTime() {
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        //assignment
        timeTextField.text = formatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }
    
    //City UIPIickerView
    func createCityPicker() {
        
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        cityPickerView.tag = 2
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedCity))
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        CityTextField.inputAccessoryView = toolbar
        CityTextField.inputView = cityPickerView
    }
    @objc func donePressedCity() {
        CityTextField.resignFirstResponder()
    }
    
    //Sport Type UIPickerView
    func createSportTypePicker() {
        SportTypeTextField.inputView = sportTypePickerView
        sportTypePickerView.tag = 1
        sportTypePickerView.delegate = self
        sportTypePickerView.dataSource = self
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedSportType))
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        SportTypeTextField.inputAccessoryView = toolbar
    }
    @objc func donePressedSportType() {
        SportTypeTextField.resignFirstResponder()
    }
    
    //for sport type
    let sportTypes = ["Select a Sporttype","Basketball","Cricket","Football","Ice Hockey", "Soccer","Table Tennis","Tennis","Volleyball"]
    var cities = ["Select a State first"]
    
    
    
    //TO CONVERT THE JSON FILE IN A DATA TO READ
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
    
    func loadCities() {
        //to reset the array, evertime a country is selected
        cities.removeAll()
        cities.append("Select a State first")
        CityTextField.placeholder = "Select a City"
        
        guard let data = readLocalFile(forName: "germany") else {
            print("Error, Reading the local data")
            return
        }
        
        var list: cityList?
        do {
            list = try JSONDecoder().decode(cityList.self, from: data)
        }
        catch let error {
            print(error)
        }
        
        guard let result = list else {
            print("Error No countries")
            return
        }

        for value in result.Cities_Germany {
            if value.state == Logged.user.state {
                cities.append(value.name)
            }
        }
    }
    
    
    func fillingCheck() -> Bool {
        //Age Check
        guard let minAgeC = Int(minAgeTextField.text!) else {
            FillmentLabel.text = "enter a valid age"
            return false
        }
        if minAgeC < 15 {
            FillmentLabel.text = "enter a valid age"
            return false
        }
        if minAgeC > Logged.user.age {
            FillmentLabel.text = "too old for you"
            return false
        }
        
        guard let maxAgeC = Int(maxAgeTextField.text!) else {
            FillmentLabel.text = "enter a valid age"
            return false
        }
        if maxAgeC > 105 || minAgeC > maxAgeC {
            FillmentLabel.text = "enter a valid"
            return false
        }
        if maxAgeC < Logged.user.age {
            FillmentLabel.text = "too young for you"
            return false
        }
        
        
        //max player count check
        guard let maxPlayerC = Int(maxPlayerTextField.text!) else {
            FillmentLabel.text = "enter a valid player count"
            return false
        }
        if maxPlayerC < 2 || maxPlayerC > 40 {
            FillmentLabel.text = "enter a valid player count"
            return false
        }
        
        //Headline Check
        let HeadLineC = HeadlineTextField.text
        if HeadLineC!.count < 1 {
            FillmentLabel.text = "Fill all the requiered fields"
            return false
        }
        
        //Sport Typ Check
        let SportTypeC = HeadlineTextField.text
        if SportTypeC!.count < 1 {
            FillmentLabel.text = "Fill all the required fields"
            return false
        }
        
        //Location Check
        let CityC = CityTextField.text
        if CityC!.count < 1 {
            FillmentLabel.text = "Fill all the requiered fields"
            return false
        }
        let LocationC = LocationTextField.text
        if LocationC!.count < 1 {
            FillmentLabel.text = "Fill all the requiered fields"
            return false
        }
        if timePicker.date.timeIntervalSinceNow < 0 {
            FillmentLabel.text = "give a valid datea and time"
            return false
        }
        
        FillmentLabel.text = ""
        return true
    }
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self,action:    #selector(dismissKeyboardTouchOutside))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
        }
        
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
}
    


extension CreateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return sportTypes.count
        case 2:
            return cities.count
        default:
            return 1 //ERROR
        }
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return sportTypes[row]
        case 2:
            return cities[row]
        default:
            return "Not found" //ERROR
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            SportTypeTextField.text = sportTypes[row]
        case 2:
            CityTextField.text = cities[row]
        default:
            return
        }
    }
}

>>>>>>> 81324ca (Initial Commit)
