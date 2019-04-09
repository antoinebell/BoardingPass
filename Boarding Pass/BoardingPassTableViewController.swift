//
//  BoardingPassTableViewController.swift
//  Boarding Pass
//
//  Created by Antoine Bellanger on 09.04.19.
//  Copyright © 2019 Antoine Bellanger. All rights reserved.
//

import UIKit

class BoardingPassTableViewController: UITableViewController {
    
    var boardingPass: BoardingPass! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Format Code :"
            cell.detailTextLabel?.text = boardingPass.formatCode
        case 1:
            cell.textLabel?.text = "Legs :"
            cell.detailTextLabel?.text = boardingPass.legsNumber.string
        case 2:
            cell.textLabel?.text = "Full Name :"
            cell.detailTextLabel?.text = boardingPass.fullName
        case 3:
            cell.textLabel?.text = "Electronic Ticket Indicator :"
            cell.detailTextLabel?.text = boardingPass.electronicTicketIndicator
        case 4:
            cell.textLabel?.text = "Reservation Number :"
            cell.detailTextLabel?.text = boardingPass.reservationNumber
        case 5:
            cell.textLabel?.text = "From :"
            cell.detailTextLabel?.text = boardingPass.fromCityIATA
        case 6:
            cell.textLabel?.text = "To :"
            cell.detailTextLabel?.text = boardingPass.toCityIATA
        case 7:
            cell.textLabel?.text = "Carrier :"
            cell.detailTextLabel?.text = boardingPass.operatingCarrier
        case 8:
            cell.textLabel?.text = "Flight Number :"
            cell.detailTextLabel?.text = boardingPass.flightNumber
        case 9:
            cell.textLabel?.text = "Flight Date :"
            cell.detailTextLabel?.text = boardingPass.flightDate.string
        case 10:
            cell.textLabel?.text = "Compartment Code :"
            cell.detailTextLabel?.text = boardingPass.compartmentCode
        case 11:
            cell.textLabel?.text = "Seat :"
            cell.detailTextLabel?.text = boardingPass.seatNumber
        case 12:
            cell.textLabel?.text = "Sequence :"
            cell.detailTextLabel?.text = boardingPass.sequenceNumber.string
        case 13:
            cell.textLabel?.text = "Passenger Status :"
            cell.detailTextLabel?.text = boardingPass.passengerStatus.string
        case 14:
            cell.textLabel?.text = "Variable Size :"
            cell.detailTextLabel?.text = boardingPass.variableSize.string
        case 15:
            cell.textLabel?.text = "Version # Beginning :"
            cell.detailTextLabel?.text = boardingPass.versionNumberBeginning
        case 16:
            cell.textLabel?.text = "Version # :"
            cell.detailTextLabel?.text = boardingPass.versionNumber
        case 17:
            cell.textLabel?.text = "Following Data Structure :"
            cell.detailTextLabel?.text = boardingPass.followingStructureMessageSize.string
        case 18:
            cell.textLabel?.text = "Passenger Description :"
            cell.detailTextLabel?.text = boardingPass.passengerDescription.string
        case 19:
            cell.textLabel?.text = "Check-In Source :"
            cell.detailTextLabel?.text = boardingPass.checkInSource
        case 20:
            cell.textLabel?.text = "Boarding Pass Source :"
            cell.detailTextLabel?.text = boardingPass.boardingPassSource
        case 21:
            cell.textLabel?.text = "Boarding Pass Issue Date :"
            cell.detailTextLabel?.text = boardingPass.boardingPassIssueDate
        case 22:
            cell.textLabel?.text = "Document Type :"
            cell.detailTextLabel?.text = boardingPass.documentType
        case 23:
            cell.textLabel?.text = "Boarding Pass Issuer :"
            cell.detailTextLabel?.text = boardingPass.airlineBoardingPassIssuer
        case 24:
            cell.textLabel?.text = "Baggage Tag :"
            cell.detailTextLabel?.text = boardingPass.baggageTag
        default:
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
