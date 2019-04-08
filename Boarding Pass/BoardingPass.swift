//
//  BoardingPass.swift
//  Boarding Pass
//
//  Created by Antoine Bellanger on 08.04.19.
//  Copyright © 2019 Antoine Bellanger. All rights reserved.
//

import Foundation

struct BoardingPass: Decodable {
    
    //MARK: - Mandatory Items
    
    /// Field size of the mandatory items.
    private let mandatoryItemsSize: Int = 60
    
    /// Format Code of the boarding pass.
    /// Usually "M".
    let formatCode: String //M
    
    /// The number of legs included in the boarding pass data.
    /// Example : "1", "2", ...
    let legsNumber: Int
    
    /// Full name of the boarding pass. Truncated to the first 20 characters.
    /// Format : "LASTNAME/FULLNAME"
    let fullName: String
    
    /// Electronic Ticket Indicator.
    /// Usually "E".
    let electronicTicketIndicator: String
    
    /// A 6 or 7 character booking identifier (airline).
    /// Example : "QAPBNA ", "EW3NM4C"
    let reservationNumber: String
    
    /// The IATA code of the flight origin.
    /// Example : "GVA", "ZRH"
    let fromCityIATA: String
    
    /// The IATA code of the flight destination.
    /// Example : "JFK", "SFO"
    let toCityIATA: String
    
    /// Designator of the operating carrier. IATA or ICAO.
    /// Example : "LX", "EZS"
    let operatingCarrier: String
    
    /// Flight number. 5 characters.
    /// Example : "0022 ", "2616 ", "10374"
    let flightNumber: String
    
    /// Flight Date in the Julian calendar.
    /// Example : "226" (August 14th)
    let flightDate: Int
    
    /// Compartement Code which is not the same as the booking fare class.
    /// Example : "Y", "M", "R"
    let compartmentCode: String
    
    /// Seat Number. 4 characters.
    /// Example : "001A", "022E", "104A"
    let seatNumber: String
    
    /// The Check-In Sequence Number.
    /// Example : "0025 ", "10523"
    let sequenceNumber: Int
    
    /// The current passenger status
    /// Usually : 3
    let passengerStatus: Int
    
    /// The size of the variable field. Hexadecimal converted to Int.
    /// Example : "5D" (93), "4D" (77), "0A (10)
    let variableSize: Int
    
    //MARK: - Conditional Items
    
    /// **Conditional** | The beginning of the version number.
    /// Example : ">", "1"
    let versionNumberBeginning: String
    /// Size of the `versionNumberBeginning`.
    private let versionNumberBeginningSize: Int = 1
    /// Size of the combined previous conditional data.
    private let versionNumberBeginningConditionalSize: Int = 0
    
    /// **Conditional** | The version number.
    /// Example : "2", "5", "8"
    let versionNumber: String
    /// Size of the `versionNumber`.
    private let versionNumberSize: Int = 1
    /// Size of the combined previous conditional data.
    private let versionNumberConditionalSize: Int = 1
    
    /// **Conditional** | The field size of the following structured message.
    /// Count for the length of the conditional data identified as unique (the 7 next variables)
    /// Example : "18"
    let followingStructureMessageSize: Int
    /// Size of the `followingStructureMessageSize`.
    private let followingStructureMessageSizeSize: Int = 2
    /// Size of the combined previous conditional data.
    private let followingStructureMessageSizeConditionalSize: Int = 2
    
    /// **Conditional** | The description of the passenger.
    /// Example : "0" (adult), "4" (infant), "6" (adult with an infant)
    let passengerDescription: Int
    /// Size of the `passengerDescription`.
    private let passengerDescriptionSize: Int = 1
    /// Size of the combined previous conditional data.
    private let passengerDescriptionConditionalSize: Int = 4
    
    //MARK: - Initialisation
    init(from data: String) throws {
        
        //Mandatory
        
        //Format Code
        self.formatCode = data[0].string
        
        //Legs Number
        guard data[1].string.isInt else {
            throw BoardingPassError.invalidLegsNumber
        }
        self.legsNumber = Int(data[1].string)!
        
        //Full Name
        self.fullName = data[2...21].string.trimmingCharacters(in: .whitespaces)
        
        //Electronic Ticket Indicator
        self.electronicTicketIndicator = data[22].string
        
        //Reservation Number
        self.reservationNumber = data[23...29].string.trimmingCharacters(in: .whitespaces)
        
        //Origin City IATA
        self.fromCityIATA = data[30...32].string
        
        //Destination City IATA
        self.toCityIATA = data[33...35].string
        
        //Operating Carrier
        self.operatingCarrier = data[36...38].string.trimmingCharacters(in: .whitespaces)
        
        //Flight Number
        self.flightNumber = data[39...43].string.trimmingCharacters(in: .whitespaces)
        
        //Flight Date
        self.flightDate = Int(data[44...46].string) ?? 000
        
        //Compartment Code
        self.compartmentCode = data[47].string
        
        //Seat Number
        self.seatNumber = data[48...51].string
        
        //Sequence
        self.sequenceNumber = Int(data[52...56].string.trimmingCharacters(in: .whitespaces)) ?? 00000
        
        //Passenger Status
        self.passengerStatus = Int(data[57].string) ?? 0
        
        //Variable size
        let fieldSize = data[58...59].string
        guard let value = UInt8(fieldSize, radix: 16) else {
            throw BoardingPassError.invalidHexadecimal
        }
        self.variableSize = Int(value)
        
        //Conditional
        
        //Version number beginning
        if self.variableSize > (versionNumberBeginningConditionalSize + versionNumberBeginningSize) {
            self.versionNumberBeginning = data[mandatoryItemsSize + versionNumberBeginningConditionalSize].string
        } else {
            self.versionNumberBeginning = ""
        }
        
        //Version number
        if self.variableSize > (versionNumberConditionalSize + versionNumberSize) {
            self.versionNumber = data[mandatoryItemsSize + versionNumberConditionalSize].string
        } else {
            self.versionNumber = "0"
        }
        
        //Following structure message size
        if self.variableSize > (followingStructureMessageSizeConditionalSize + followingStructureMessageSizeSize) {
            let startIndex = mandatoryItemsSize + followingStructureMessageSizeConditionalSize
            let endIndex = mandatoryItemsSize + followingStructureMessageSizeConditionalSize + followingStructureMessageSizeSize - 1
            let messageSize = data[startIndex...endIndex].string
            print(messageSize)
            guard let value = UInt8(messageSize, radix: 16) else {
                throw BoardingPassError.invalidHexadecimal
            }
            self.followingStructureMessageSize = Int(value)
        } else {
            self.followingStructureMessageSize = 0
        }

        //Passenger description
        if self.variableSize > (passengerDescriptionConditionalSize + passengerDescriptionSize) {
            let index = mandatoryItemsSize + passengerDescriptionConditionalSize
            guard data[index].string.isInt else {
                throw BoardingPassError.invalidPassengerDescription
            }
            self.passengerDescription = Int(data[index].string)!
        } else {
            self.passengerDescription = 99
        }
        
    }
    
}

enum BoardingPassError: Error {
    
    case invalidLegsNumber
    case invalidHexadecimal
    case invalidPassengerDescription
}

// Extensions for the substring
// Source : https://goo.gl/y7Yimm

extension StringProtocol {
    
    subscript(offset: Int) -> Element {
        return self[index(startIndex, offsetBy: offset)]
    }
    
    subscript(_ range: CountableRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    subscript(range: CountableClosedRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    
    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        return prefix(range.upperBound.advanced(by: 1))
    }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        return prefix(range.upperBound)
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        return suffix(Swift.max(0, count - range.lowerBound))
    }
}

extension LosslessStringConvertible {
    var string: String { return String(self) }
}

extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
