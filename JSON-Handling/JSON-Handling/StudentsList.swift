//
//  StudentsList.swift
//  JSON-Handling
//
//  Created by Suraj Mirajkar on 14/03/22.
//

import Foundation

struct StudentsList: Codable {
    let students : [Students]?
}

struct Students: Codable {
    let fullName: String?
    let standard: Int? //let `class`: Int?
    let division: String
    let rollNo: RollNoType //let rollNo: Int?
    let enrollmentDate: Date?
    
    private enum CodingKeys: String, CodingKey {
        case fullName, division
        case standard = "class"
        case rollNo = "roll_no"
        case enrollmentDate = "enrollment_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fullName = try container.decode(String.self, forKey: .fullName)
        standard = try container.decode(Int.self, forKey: .standard)
        division = try container.decodeIfPresent(String.self, forKey: .division) ?? "A"
        rollNo = try container.decode(RollNoType.self, forKey: .rollNo) //rollNo = try container.decode(Int.self, forKey: .rollNo)
        enrollmentDate = try container.decode(Date.self, forKey: .enrollmentDate)
    }
}

enum RollNoType: Codable {
    case int(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        if let intVal = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(intVal)
            return
        }
        if let strVal = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(strVal)
            return
        }
        throw RollNoTypeError.missingVal
    }
    
    enum RollNoTypeError: Error {
        case missingVal
    }
}

