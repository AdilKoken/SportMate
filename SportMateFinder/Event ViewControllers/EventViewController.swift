//
//  EventViewController.swift
//  SportMateFinder
//
//  Created by Adil Köken on 22.12.20.
//

<<<<<<< HEAD
import Foundation
=======
import UIKit

class EventViewController: UIViewController {
    
    @IBOutlet weak var sportTypeLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentPlayerCountLabel: UILabel!
    @IBOutlet weak var ageIntervalLabel: UILabel!
    @IBOutlet weak var playersTextView: UITextView!
    @IBOutlet var assignmentBtn: UIButton!
    var event: sportEvent!
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        playersTextView.isEditable = false
        self.navigationItem.backBarButtonItem?.tintColor = .label
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationItem.title = event.headLine
        sportTypeLabel.text = "  Sport Type: " + event.type
        CityLabel.text = "  City: " + event.city
        LocationLabel.text = " " + event.locationAdress
        let NSDate = Date(timeIntervalSince1970: TimeInterval(event.time))
        timeLabel.text = "  Time: " + formatter.string(from: NSDate)
        ageIntervalLabel.text = "  Age Interval:  " + String(event.ageMin) + " - " + String(event.ageMax)
        refresh()
    }
    
    @IBAction func assignment() {
        // if already in, use the button to out
        if event.registredUser.contains(Logged.user.username) {
            EventDatabase.shared.dismissAsissignment(eventID: event.eventID)
        }
        // if the player limit is full, don't let the user to assign
        else if event.currentPlayerCount >= event.maxPlayerCount {
            return
        }
        // else (if not) join
        else {
            EventDatabase.shared.assignUser(eventID: event.eventID, time: event.time)
        }
        refresh()
    }
    
    func refresh() {
        event.registredUser = EventDatabase.shared.getRegistredUsers(id: event.eventID)
        event.currentPlayerCount = EventDatabase.shared.selectCurrentPlayerCount(ID: event.eventID)
        
        currentPlayerCountLabel.text = "  Player Limit:  " + String(event.currentPlayerCount) + "/" + String(event.maxPlayerCount)
        
        playersTextView.text = ""
        for name in event.registredUser {
            playersTextView.text = (playersTextView.text ?? "") + "\(name)\n"
        }
        
        if event.registredUser.contains(Logged.user.username) {
            assignmentBtn.setTitle("Dismiss", for: .normal)
        }
        else if event.currentPlayerCount >= event.maxPlayerCount {
            assignmentBtn.setTitle("No Place", for: .normal)
        }
        else {
            assignmentBtn.setTitle("Join", for: .normal)
        }
    }
}
>>>>>>> 81324ca (Initial Commit)
