<<<<<<< HEAD
//
//  FilterEventsViewController.swift
//  SportMateFinder
//
//  Created by Adil Köken on 23.12.20.
//
=======
>>>>>>> 81324ca (Initial Commit)

import UIKit


<<<<<<< HEAD
=======

class EventFilterViewController: UIViewController {
    
    
    
    @IBOutlet var SportTypeTextField: UITextField!
    @IBOutlet var CityTextField: UITextField!
    @IBOutlet var DateFromTextField: UITextField!
    @IBOutlet var DateTillTextField: UITextField!
    
    @IBAction func cancelBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyBtn() {
        if CityTextField.text != "" || SportTypeTextField.text != "" || DateFromTextField.text != "" || DateTillTextField.text != "" {
            filter.filtered = true
            filter.city = CityTextField.text ?? ""
            filter.type = SportTypeTextField.text ?? ""
            filter.dateFrom = Int(timePickerFrom.date.timeIntervalSince1970)
            filter.dateTill = Int(timePickerTill.date.timeIntervalSince1970)
        }
        if DateTillTextField.text == "" {
            filter.dateTill = 0
        }
        if DateFromTextField.text == "" {
            filter.dateFrom = 0
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        loadCities()
        createCityPicker()
        createSportTypePicker()
        createDatePickerFrom()
        createDatePickerTill()
        self.dismissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        SportTypeTextField.placeholder = "Select Type"
        CityTextField.placeholder = "Select City"
        DateFromTextField.placeholder = "Date From"
        DateTillTextField.placeholder = "Date Till"
    }
    
    //Sport Type UIPickerView
    let sportTypes = ["Select a Sporttype","Basketball","Cricket","Football","Ice Hockey", "Soccer","Table Tensis","Tennis","Voleyball"]
    var sportTypePickerView = UIPickerView()

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
    
    //Time Picker
    var timePickerFrom = UIDatePicker()
    func createDatePickerFrom() {
        //toolbar
        let toolbarFrom = UIToolbar()
        toolbarFrom.sizeToFit()
        
        
        //bar button
        let doneBtnFrom = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedFrom))
        toolbarFrom.setItems([doneBtnFrom], animated: true)
        //assign toolbar
        DateFromTextField.inputAccessoryView = toolbarFrom
        
        //assing timePicker
        DateFromTextField.inputView = timePickerFrom
        
        //time picker mode
        timePickerFrom.datePickerMode = .dateAndTime
        timePickerFrom.preferredDatePickerStyle = .wheels

    }
    
    @objc func donePressedFrom() {
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        //assignment
        DateFromTextField.text = formatter.string(from: timePickerFrom.date)
        self.view.endEditing(true)
    }
    var timePickerTill = UIDatePicker()
    func createDatePickerTill() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedTill))
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        DateTillTextField.inputAccessoryView = toolbar
        
        //assing timePicker
        DateTillTextField.inputView = timePickerTill
        
        //time picker mode
        timePickerTill.datePickerMode = .dateAndTime
        timePickerTill.preferredDatePickerStyle = .wheels
    }
    @objc func donePressedTill() {
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        //assignment
        DateTillTextField.text = formatter.string(from: timePickerTill.date)
        self.view.endEditing(true)
    }
    
    //City UIPIickerView
    var cityPickerView = UIPickerView()
    var cities = ["Select a State first"]
    
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
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self,action:    #selector(dismissKeyboardTouchOutside))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
        }
        
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
}

extension EventFilterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
