//
//  UpcomingViewController.swift
//  SportMateFinder
//
//  Created by Adil Köken on 22.12.20.
//

<<<<<<< HEAD
import Foundation
=======
import UIKit

class UpcomingEventsTable: UITableViewController {
    
    //Filtered eventlist, to display
    var eventList: [sportEvent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        getEvents()
        tableView.reloadData()
        
        //refresh the table view, when the user pulls the screen down
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(doRefresh(refreshControl:)), for: .valueChanged)

        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        tableView.refreshControl = refreshControl
    }
    
    //refresh func for pull
    @objc func doRefresh(refreshControl: UIRefreshControl) {
        self.viewDidAppear(true)
        refreshControl.endRefreshing()
    }
    
    func getEvents() {
        eventList.removeAll()
        guard EventDatabase.shared.getMyEvents() != nil else {
            return
        }
        eventList = EventDatabase.shared.getMyEvents()
        //sort the list with increasing time to present the list properly
        eventList.sort{
            $0.time < $1.time
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
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
}
>>>>>>> 81324ca (Initial Commit)
