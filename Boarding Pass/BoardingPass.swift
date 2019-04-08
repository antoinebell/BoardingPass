//
//  BoardingPass.swift
//  Boarding Pass
//
//  Created by Antoine Bellanger on 08.04.19.
//  Copyright © 2019 Antoine Bellanger. All rights reserved.
//

import Foundation

struct BoardingPass: Decodable {
    let flights: String //M1 / M2
    let fullName: String //LASTNAME/FIRSTNAME
    let reservationNumber: String //XXXXXX
    let origin: String //GVA
    let destination: String //SFO
    let flightCode: String //LX / EZS
    let flightNumber: String //1419
    
    init(from data: String) throws {
        
        guard data[39...42].string.isInt else {
            throw BoardingPassError.invalidFlightNumber
        }
        
        self.flights = data[0...1].string
        self.fullName = data[2...21].string.trimmingCharacters(in: .whitespaces)
        self.reservationNumber = data[22...29].string.trimmingCharacters(in: .whitespaces)
        self.origin = data[30...32].string
        self.destination = data[33...35].string
        self.flightCode = data[36...38].string.trimmingCharacters(in: .whitespaces)
        self.flightNumber = data[39...42].string.trimmingCharacters(in: .whitespaces)
    }
    
}

enum BoardingPassError: Error {
    
    case invalidFlightNumber
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

