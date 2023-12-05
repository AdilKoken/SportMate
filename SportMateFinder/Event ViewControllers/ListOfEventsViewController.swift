//
//  ListOfEventsViewController.swift
//  SportMateFinder
//
//  Created by Adil Köken on 22.12.20.
//

import UIKit

class ListOfEventsViewController: UITableViewController {
<<<<<<< HEAD
    
=======
    @IBOutlet var FilterBtn: UIBarButtonItem!
    
    @IBAction func filterAct() {
        if filter.filtered == false {
            performSegue(withIdentifier: "FilterSegue", sender: nil)
        }
        else {
            filter.filtered = false
            FilterBtn.title = "Filter"
            
            viewDidAppear(true)
            tableView.reloadData()
        }
    }
    
    //Unfiltered eventlist, to get primeKey as rowid
    var wholeEventList: [sportEvent] = []
    //Filtered eventlist, to display
>>>>>>> 81324ca (Initial Commit)
    var eventList: [sportEvent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventList.removeAll()
        eventList = EventDatabase.shared.getAllEvents()
        tableView.reloadData()
    }
    
=======
        self.navigationItem.hidesBackButton = true
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        EventDatabase.shared.cleanOutdated()
        //check if a user logged id
        if Logged.user.id < 1 {
            performSegue(withIdentifier: "notLogged", sender: nil)
            return
        }
        if filter.filtered == false {
            FilterBtn.title = "Filter"
        }
        else {
            FilterBtn.title = "Cancel Filter"
        }
        
        wholeEventList = EventDatabase.shared.getAllEvents()
        getEvents()
        tableView.reloadData()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(doRefresh(refreshControl:)), for: .valueChanged)

        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        tableView.refreshControl = refreshControl
    }
    
    @objc func doRefresh(refreshControl: UIRefreshControl) {
        self.viewDidAppear(true)
        refreshControl.endRefreshing()
    }
    
    func getEvents() {
        eventList.removeAll()
        if filter.filtered == false {
            for value in wholeEventList {
                if Logged.user.age <= value.ageMax && Logged.user.age >= value.ageMin {
                    eventList.append(value)
                }
            }
        }
        else {
            for value in wholeEventList {
                
                if Logged.user.age <= value.ageMax && Logged.user.age >= value.ageMin {
                    
                    if filter.dateTill == 0 {
                        filter.dateTill = 99999999999
                    }
                                        
                    if filter.city != "" && filter.type != "" {
                        if value.city == filter.city && value.type == filter.type && value.time > filter.dateFrom && value.time < filter.dateTill {
                            eventList.append(value)
                        }
                    }
                    else if filter.city != "" {
                        if value.city == filter.city && value.time > filter.dateFrom && value.time < filter.dateTill {
                            eventList.append(value)
                        }
                    
                    }
                    else if filter.type != "" {
                        if value.type == filter.type && value.time > filter.dateFrom && value.time < filter.dateTill {
                            eventList.append(value)
                        }
                    }
                    else {
                        if value.time > filter.dateFrom && value.time < filter.dateTill {
                            eventList.append(value)
                        }
                    }
                }
            }
        }
        //sort the list with increasing time to present the list properly
        eventList.sort{
            $0.time < $1.time
        }
    }

>>>>>>> 81324ca (Initial Commit)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
<<<<<<< HEAD
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        cell.textLabel?.text = eventList[indexPath.row].headLine
        return cell
    }
    
=======
    let formatter = DateFormatter()
    
        
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        
        let event = eventList[indexPath.row]
        
        cell.headlineLbl.text = event.headLine
        cell.cityLbl.text = "City: \(event.city)"
        cell.limitLbl.text = "\(String(event.currentPlayerCount))/\(String(event.maxPlayerCount))"
        cell.ageIntervalLbl.text = "Age: \(String(event.ageMin)) - \(String(event.ageMax))"
        cell.sportTypeLbl.text = event.type
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        cell.timeLbl.text = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(event.time)))
        
        let modulo = indexPath.row % 4
        if  modulo == 0 {
            cell.cellView.backgroundColor = UIColor.systemPurple
        }
        else if modulo == 1 {
                cell.cellView.backgroundColor = UIColor.systemGreen
        }
        else if modulo == 2 {
            cell.cellView.backgroundColor = UIColor.systemRed
        }
        else {
            cell.cellView.backgroundColor = UIColor.systemBlue
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventDetailSegue",
           let destination = segue.destination as? EventViewController,
           let index = tableView.indexPathForSelectedRow?.row {
            if filter.filtered == false {
                destination.event = EventDatabase.shared.getOneEvent(id: eventList[index].eventID)
            }
            
           }
        }
>>>>>>> 81324ca (Initial Commit)
}
