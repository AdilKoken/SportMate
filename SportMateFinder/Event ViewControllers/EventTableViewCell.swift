//
//  EventTableViewCell.swift
//  SportMateFinder
//
//  Created by Adil Köken on 22.12.20.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var headlineLbl: UILabel!
    @IBOutlet weak var sportTypeLbl: UILabel!
    @IBOutlet weak var limitLbl: UILabel!
<<<<<<< HEAD
    @IBOutlet weak var ageIntervalLbl: UILabel!
=======
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var ageIntervalLbl: UILabel!
    
>>>>>>> 81324ca (Initial Commit)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
