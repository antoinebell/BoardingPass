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
    private let kMandatoryItemsSize: Int = 60
    
    /// Format Code of the boarding pass.
    /// *- Item 1 -*
    /// Usually "M".
    let formatCode: String //M
    
    /// The number of legs included in the boarding pass data.
    /// *- Item 5 -*
    /// Example : "1", "2", ...
    let legsNumber: Int
    
    /// Full name of the boarding pass. Truncated to the first 20 characters.
    /// *- Item 11 -*
    /// Format : "LASTNAME/FULLNAME"
    let fullName: String
    
    /// Distinguishes an electronic ticket from a ticketless product.
    /// *- Item 253 -*
    /// Usually "E".
    let electronicTicketIndicator: String
    
    /// A 6 or 7 character booking identifier (airline).
    /// *- Item 7 -*
    /// Example : "QAPBNA ", "EW3NM4C"
    let reservationNumber: String
    
    /// The IATA code of the flight origin.
    /// *- Item 26 -*
    /// Example : "GVA", "ZRH"
    let fromCityIATA: String
    
    /// The IATA code of the flight destination.
    /// *- Item 38 -*
    /// Example : "JFK", "SFO"
    let toCityIATA: String
    
    /// Designator of the operating carrier. IATA or ICAO.
    /// *- Item 42 -*
    /// Example : "LX", "EZS"
    let operatingCarrier: String
    
    /// Flight number. 5 characters.
    /// *- Item 43 -*
    /// Example : "0022 ", "2616 ", "10374"
    let flightNumber: String
    
    /// Flight Date in the Julian calendar.
    /// *- Item 46 -*
    /// Example : "226" (August 14th)
    let flightDate: Int
    
    /// Compartement Code which is not the same as the booking fare class.
    /// *- Item 71 -*
    /// Example : "Y", "M", "R"
    let compartmentCode: String
    
    /// Seat Number. 4 characters.
    /// *- Item 104 -*
    /// Example : "001A", "022E", "104A"
    let seatNumber: String
    
    /// The Check-In Sequence Number.
    /// *- Item 107 -*
    /// Example : "0025 ", "10523"
    let sequenceNumber: Int
    
    /// The current passenger status
    /// *- Item 113 -*
    /// Usually : 3
    let passengerStatus: Int
    
    /// The size of the variable field. Hexadecimal converted to Int.
    /// *- Item 6 -*
    /// Example : "5D" (93), "4D" (77), "0A (10)
    let variableSize: Int
    
    //MARK: - Conditional Items
    
    /// Field size of the mandatory items.
    private let kConditionalUniqueItemsSize: Int = 28
    
    /// **Conditional** | The beginning of the version number.
    /// *- Item 8 -*
    /// Example : ">", "1"
    let versionNumberBeginning: String
    /// Size of the `versionNumberBeginning`.
    private let kVersionNumberBeginningSize: Int = 1
    /// Size of the combined previous conditional data.
    private let kVersionNumberBeginningPrevious: Int = 0
    
    /// **Conditional** | The version number.
    /// *- Item 9 -*
    /// Example : "2", "5", "8"
    let versionNumber: String
    /// Size of the `versionNumber`.
    private let kVersionNumberSize: Int = 1
    /// Size of the combined previous conditional data.
    private let kVersionNumberSizePrevious: Int = 1
    
    /// **Conditional** | The field size of the following structured message.
    /// *- Item 10 -*
    /// Count for the length of the conditional data identified as unique (the 7 next variables)
    /// Example : "18"
    let followingStructureMessageSize: Int
    /// Size of the `followingStructureMessageSize`.
    private let kFollowingStructureMessageSizeSize: Int = 2
    /// Size of the combined previous conditional data.
    private let kFollowingStructureMessageSizePrevious: Int = 2
    
    /// **Conditional** | The description of the passenger.
    /// *- Item 15 -*
    /// Example : "0" (adult), "4" (infant), "6" (adult with an infant)
    let passengerDescription: String
    /// Size of the `passengerDescription`.
    private let kPassengerDescriptionSize: Int = 1
    /// Size of the combined previous conditional data.
    private let kPassengerDescriptionSizePrevious: Int = 4
    /// Size of the combined previous structured message (Item 10)
    private let kPassengerDescriptionSizeStructuredPrevious: Int = 0
    
    /// **Conditional** | Where the passenger initiated the check-in.
    /// *- Item 12 -*
    let checkInSource: String
    /// Size of `checkInSource`
    private let kCheckInSourceSize: Int = 1
    /// Size of the combined previous data.
    private let kCheckInSourceSizePrevious: Int = 5
    /// Size of the combined previous structured message (Item 10)
    private let kCheckInSourceSizeStructuredPrevious: Int = 1
    
    /// **Conditional** | Where the boarding pass was issued.
    /// *- Item 14 -*
    let boardingPassSource: String
    /// Size of `checkInSource`
    private let kBoardingPassSourceSize: Int = 1
    /// Size of the combined previous data.
    private let kBoardingPassSizePrevious: Int = 6
    /// Size of the combined previous structured message (Item 10)
    private let kBoardingPassSizeStructuredPrevious: Int = 2
    
    /// **Conditional** | Date formed from the last digit of the year the boarding pass was issued and the number of elapsed days since the beginning of that particular year
    /// *- Item 22 - *
    let boardingPassIssueDate: String
    /// Size of `boardingPassIssueDate`
    private let kBoardingPassIssueDateSize: Int = 4
    /// Size of the combined previous data.
    private let kBoardingPassIssueDateSizePrevious: Int = 7
    /// Size of the combined previous structured message (Item 10)
    private let kBoardingPassIssueDateSizeStructuredPrevious: Int = 3
    
    /// **Conditional** | Indicates if the document is a boarding pass or an itinary receipt
    /// *- Item 16 -*
    /// Example : "B"
    let documentType: String
    /// Size of `documentType`
    private let kDocumentTypeSize: Int = 1
    /// Size of the combined previous data.
    private let kDocumentTypeSizePrevious: Int = 11
    /// Size of the combined previous structured message (Item 10)
    private let kDocumentTypeSizeStructuredPrevious: Int = 7
    
    /// **Conditional** | Airline designator of boarding pass issuer
    /// *- Item 21 -*
    /// Example : "LX", "SK"
    let airlineBoardingPassIssuer: String
    /// Size of `airlineBoardingPassIssuer`
    private let kAirlineBoardingPassIssuerSize: Int = 3
    /// Size of the combined previous data.
    private let kAirlineBoardingPassIssuerSizePrevious: Int = 12
    /// Size of the combined previous structured message (Item 10)
    private let kAirlineBoardingPassIssuerSizeStructuredPrevious: Int = 8
    
    /// **Conditional** | Bag tag numbers and number of consecutive bags
    /// *- Item 23 -*
    /// Example : "LX", "SK"
    let baggageTag: String
    /// Size of `baggageTag`
    private let kBaggageTagSize: Int = 13
    /// Size of the combined previous data.
    private let kBaggageTagSizePrevious: Int = 15
    /// Size of the combined previous structured message (Item 10)
    private let kBaggageTagSizeStructuredPrevious: Int = 11
    
    /// **Conditional** | The field size of the following repeated structured message.
    /// *- Item 17 -*
    /// Count for the length of the conditional data identified as unique (the 7 next variables)
    /// Example : "18"
    let followingStructureMessageSizeRepeated: Int
    
    /// **Conditional** | The airline numeric code.
    /// *- Item 142 -*
    /// Example : "724" (LX), "117" (SK)
    let airlineNumericCode: Int
    /// Size of `airlineNumericCode`
    private let kAirlineNumericCodeSize: Int = 3
    /// Size of the combined previous data.
    private let kAirlineNumericCodeSizePrevious: Int = 2
    /// Size of the combined previous data (Item 17).
    private let kAirlineNumericCodeSizeStructuredPrevious: Int = 0
    
    /// **Conditional** | The ticket number.
    /// *- Item 143 -*
    /// Example : "1234567890"
    let documentSerialNumber: Int
    /// Size of `airlineNumericCode`
    private let kDocumentSerialNumberSize: Int = 10
    /// Size of the combined previous data.
    private let kDocumentSerialNumberSizePrevious: Int = 5
    /// Size of the combined previous data (Item 17).
    private let kDocumentSerialNumberSizeStructuredPrevious: Int = 3
    
    /// **Conditional** | Selectee indicator. Used by some agencies for additional screening.
    /// *- Item 18 -*
    let selecteeIndicator: String
    /// Size of `airlineNumericCode`
    private let kSelecteeIndicatorSize: Int = 1
    /// Size of the combined previous data.
    private let kSelecteeIndicatorSizePrevious: Int = 15
    /// Size of the combined previous data (Item 17).
    private let kSelecteeIndicatorSizeStructuredPrevious: Int = 14
    
    /// **Conditional** | Assists carriers to identify passengers requiring travel documents verification.
    /// *- Item 108 -*
    let internationalDocumentationVerification: String
    /// Size of `airlineNumericCode`
    private let kInternationalDocumentationVerificationSize: Int = 1
    /// Size of the combined previous data.
    private let kInternationalDocumentationVerificationSizePrevious: Int = 16
    /// Size of the combined previous data (Item 17).
    private let kInternationalDocumentationVerificationSizeStructuredPrevious: Int = 15
    
    /// **Conditional** | Marketing Carrier designator.
    /// *- Item 19 -*
    let carrierDesignator: String
    /// Size of `airlineNumericCode`
    private let kCarrierDesignatorSize: Int = 3
    /// Size of the combined previous data.
    private let kCarrierDesignatorSizePrevious: Int = 17
    /// Size of the combined previous data (Item 17).
    private let kCarrierDesignatorSizeStructuredPrevious: Int = 19
    
    /// **Conditional** | Frequent Flier Airline designator.
    /// *- Item 20 -*
    let frequentFlierDesignator: String
    /// Size of `airlineNumericCode`
    private let kFrequentFlierDesignatorSize: Int = 3
    /// Size of the combined previous data.
    private let kFrequentFlierDesignatorSizePrevious: Int = 20
    /// Size of the combined previous data (Item 17).
    private let kFrequentFlierDesignatorSizeStructuredPrevious: Int = 22
    
    /// **Conditional** | Frequent Flier number.
    /// *- Item 236 -*
    let frequentFlierNumber: Int
    /// Size of `airlineNumericCode`
    private let kFrequentFlierNumberSize: Int = 16
    /// Size of the combined previous data.
    private let kFrequentFlierNumberSizePrevious: Int = 23
    /// Size of the combined previous data (Item 17).
    private let kFrequentFlierNumberSizeStructuredPrevious: Int = 25
    
    /// **Conditional** | ID/AD indicator.
    /// *- Item 89 -*
    let idAdIndicator: String
    /// Size of `airlineNumericCode`
    private let kIdAdIndicatorSize: Int = 1
    /// Size of the combined previous data.
    private let kIdAdIndicatorSizePrevious: Int = 39
    /// Size of the combined previous data (Item 17).
    private let kIdAdIndicatorSizeStructuredPrevious: Int = 41
    
    /// **Conditional** | Free baggage allowance.
    /// *- Item 118 -*
    let freeBaggageAllowance: String
    /// Size of `airlineNumericCode`
    private let kFreeBaggageAllowanceSize: Int = 3
    /// Size of the combined previous data.
    private let kFreeBaggageAllowanceSizePrevious: Int = 40
    /// Size of the combined previous data (Item 17).
    private let kFreeBaggageAllowanceSizeStructuredPrevious: Int = 42
    
    /// **Conditional** | Fast track security check.
    /// *- Item 254 -*
    let fastTrack: String
    /// Size of `airlineNumericCode`
    private let kFastTrackSize: Int = 1
    /// Size of the combined previous data.
    private let kFastTrackSizePrevious: Int = 43
    /// Size of the combined previous data (Item 17).
    private let kFastTrackSizeStructuredPrevious: Int = 45
    
    
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
        if self.variableSize >= (kVersionNumberBeginningPrevious + kVersionNumberBeginningSize) {
            self.versionNumberBeginning = data[kMandatoryItemsSize + kVersionNumberBeginningPrevious].string
        } else {
            self.versionNumberBeginning = ""
        }
        
        //Version number
        if self.variableSize >= (kVersionNumberSizePrevious + kVersionNumberSize) {
            self.versionNumber = data[kMandatoryItemsSize + kVersionNumberSizePrevious].string
        } else {
            self.versionNumber = "0"
        }
        
        //Following structure message size
        if self.variableSize >= (kFollowingStructureMessageSizePrevious + kFollowingStructureMessageSizeSize) {
            let startIndex = kMandatoryItemsSize + kFollowingStructureMessageSizePrevious
            let endIndex = kMandatoryItemsSize + kFollowingStructureMessageSizePrevious + kFollowingStructureMessageSizeSize - 1
            let messageSize = data[startIndex...endIndex].string
            guard let value = UInt8(messageSize, radix: 16) else {
                throw BoardingPassError.invalidHexadecimal
            }
            self.followingStructureMessageSize = Int(value)
        } else {
            self.followingStructureMessageSize = 0
        }
        
        //Following structured message (Item 10)

        //Passenger description
        if self.followingStructureMessageSize >= (kPassengerDescriptionSizeStructuredPrevious + kPassengerDescriptionSize) {
            let index = kMandatoryItemsSize + kPassengerDescriptionSizePrevious
            self.passengerDescription = data[index].string
        } else {
            self.passengerDescription = ""
        }
        
        //Check-in Source
        if self.followingStructureMessageSize >= (kCheckInSourceSizeStructuredPrevious + kCheckInSourceSize) {
            let index = kMandatoryItemsSize + kCheckInSourceSizePrevious
            self.checkInSource = data[index].string
        } else {
            self.checkInSource = "No Data"
        }
        
        //Boarding Pass Source
        if self.followingStructureMessageSize >= (kBoardingPassSizeStructuredPrevious + kBoardingPassSourceSize) {
            let index = kMandatoryItemsSize + kBoardingPassSizePrevious
            self.boardingPassSource = data[index].string
        } else {
            self.boardingPassSource = "No Data"
        }
        
        //Boarding Pass Issue Date
        if self.followingStructureMessageSize >= (kBoardingPassIssueDateSizeStructuredPrevious + kBoardingPassIssueDateSize) {
            let startIndex = kMandatoryItemsSize + kBoardingPassIssueDateSizePrevious
            let endIndex = kMandatoryItemsSize + kBoardingPassIssueDateSizePrevious + kBoardingPassIssueDateSize - 1
            self.boardingPassIssueDate = data[startIndex...endIndex].string
        } else {
            self.boardingPassIssueDate = "No Data"
        }
        
        //Document Type
        if self.followingStructureMessageSize >= (kDocumentTypeSizeStructuredPrevious + kDocumentTypeSize) {
            let index = kMandatoryItemsSize + kDocumentTypeSizePrevious
            self.documentType = data[index].string
        } else {
            self.documentType = "No Data"
        }
        
        //Airline boarding pass issuer
        if self.followingStructureMessageSize >= (kAirlineBoardingPassIssuerSizeStructuredPrevious + kAirlineBoardingPassIssuerSize) {
            let startIndex = kMandatoryItemsSize + kAirlineBoardingPassIssuerSizePrevious
            let endIndex = kMandatoryItemsSize + kAirlineBoardingPassIssuerSizePrevious + kAirlineBoardingPassIssuerSize - 1
            self.airlineBoardingPassIssuer = data[startIndex...endIndex].string
        } else {
            self.airlineBoardingPassIssuer = "No Data"
        }
        
        //Baggage Tag
        if self.followingStructureMessageSize > (kBaggageTagSizeStructuredPrevious + kBaggageTagSize) {
            let startIndex = kMandatoryItemsSize + kBaggageTagSizeStructuredPrevious
            let endIndex = kMandatoryItemsSize + kBaggageTagSizeStructuredPrevious + kBaggageTagSize - 1
            self.baggageTag = data[startIndex...endIndex].string
        } else {
            self.baggageTag = "No Data"
        }
        
        //Following structure message repeated size
        let size = data[88...89].string
        guard let followingStructureRepeatedSize = UInt8(size, radix: 16) else {
            throw BoardingPassError.invalidHexadecimal
        }
        self.followingStructureMessageSizeRepeated = Int(followingStructureRepeatedSize)
        
        //Following structured message (Item 17)
        
        //Airline Numeric Code
        if self.followingStructureMessageSizeRepeated > (kAirlineNumericCodeSizeStructuredPrevious + kAirlineNumericCodeSize) {
            let startIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kAirlineNumericCodeSizePrevious
            let endIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kAirlineNumericCodeSizePrevious + kAirlineNumericCodeSize - 1
            self.airlineNumericCode = Int(data[startIndex...endIndex].string) ?? 000
        } else {
            self.airlineNumericCode = 000
        }
        
        //Document Serial Number
        if self.followingStructureMessageSizeRepeated > (kDocumentSerialNumberSizeStructuredPrevious + kDocumentSerialNumberSize) {
            let startIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kDocumentSerialNumberSizePrevious
            let endIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kDocumentSerialNumberSizePrevious + kDocumentSerialNumberSize - 1
            self.documentSerialNumber = Int(data[startIndex...endIndex].string) ?? 0000000000
        } else {
            self.documentSerialNumber = 0000000000
        }
        
        //Selectee indicator
        if self.followingStructureMessageSizeRepeated > (kSelecteeIndicatorSizeStructuredPrevious + kSelecteeIndicatorSize) {
            let startIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kSelecteeIndicatorSizePrevious
            let endIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kSelecteeIndicatorSizePrevious + kSelecteeIndicatorSize - 1
            self.selecteeIndicator = data[startIndex...endIndex].string
        } else {
            self.selecteeIndicator = ""
        }
        
        //International documentation verification
        if self.followingStructureMessageSizeRepeated > (kInternationalDocumentationVerificationSizeStructuredPrevious + kInternationalDocumentationVerificationSize) {
            let startIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kInternationalDocumentationVerificationSizePrevious
            let endIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kInternationalDocumentationVerificationSizePrevious + kInternationalDocumentationVerificationSize - 1
            self.internationalDocumentationVerification = data[startIndex...endIndex].string
        } else {
            self.internationalDocumentationVerification = ""
        }
        
        //Marketing carrier designator
        if self.followingStructureMessageSizeRepeated > (kCarrierDesignatorSizeStructuredPrevious + kCarrierDesignatorSize) {
            let startIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kCarrierDesignatorSizePrevious
            let endIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kCarrierDesignatorSizePrevious + kCarrierDesignatorSize - 1
            self.carrierDesignator = data[startIndex...endIndex].string
        } else {
            self.carrierDesignator = ""
        }
        
        //Frequent flier designator
        if self.followingStructureMessageSizeRepeated > (kFrequentFlierDesignatorSizeStructuredPrevious + kFrequentFlierDesignatorSize) {
            let startIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kFrequentFlierDesignatorSizePrevious
            let endIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kFrequentFlierDesignatorSizePrevious + kFrequentFlierDesignatorSize - 1
            self.frequentFlierDesignator = data[startIndex...endIndex].string
        } else {
            self.frequentFlierDesignator = ""
        }
        
        //Frequent flier number
        if self.followingStructureMessageSizeRepeated > (kFrequentFlierNumberSizeStructuredPrevious + kFrequentFlierNumberSize) {
            let startIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kFrequentFlierNumberSizePrevious
            let endIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kFrequentFlierNumberSizePrevious + kFrequentFlierNumberSize - 1
            self.frequentFlierNumber = Int(data[startIndex...endIndex].string.trimmingCharacters(in: .whitespaces)) ?? 0
        } else {
            self.frequentFlierNumber = 0
        }
        
        //ID/AD indicator
        if self.followingStructureMessageSizeRepeated > (kIdAdIndicatorSizeStructuredPrevious + kIdAdIndicatorSize) {
            let startIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kIdAdIndicatorSizePrevious
            let endIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kIdAdIndicatorSizePrevious + kIdAdIndicatorSize - 1
            self.idAdIndicator = data[startIndex...endIndex].string
        } else {
            self.idAdIndicator = ""
        }
        
        //Free baggage allowance
        if self.followingStructureMessageSizeRepeated > (kFreeBaggageAllowanceSizeStructuredPrevious + kFreeBaggageAllowanceSize) {
            let startIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kFreeBaggageAllowanceSizePrevious
            let endIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kFreeBaggageAllowanceSizePrevious + kFreeBaggageAllowanceSize - 1
            self.freeBaggageAllowance = data[startIndex...endIndex].string
        } else {
            self.freeBaggageAllowance = ""
        }
        
        //Fast track
        if self.followingStructureMessageSizeRepeated > (kFastTrackSizeStructuredPrevious + kFastTrackSize) {
            let startIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kFastTrackSizePrevious
            let endIndex = kMandatoryItemsSize + kConditionalUniqueItemsSize + kFastTrackSizePrevious + kFastTrackSize - 1
            self.fastTrack = data[startIndex...endIndex].string
        } else {
            self.fastTrack = ""
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
