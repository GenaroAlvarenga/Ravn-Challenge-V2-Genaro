//
//  StarWarsPersonDetail.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/7/20.
//

import Foundation

struct StarWarsPersonDetail {
    let name: String
    let eyeColor: String?
    let hairColor: String?
    let skinColor: String?
    let birthYear: String?
    let vehicles: [Vehicle]
    
    struct Vehicle {
        let name: String
    }
    
    init(_ personDetail: PersonDetailQuery.Data.Person) {
        self.name = personDetail.name ?? ""
        self.eyeColor = personDetail.eyeColor
        self.hairColor = personDetail.hairColor
        self.skinColor = personDetail.skinColor
        self.birthYear = personDetail.birthYear
        if let vehiclesConnection = personDetail.vehicleConnection?.vehicles {
            self.vehicles = vehiclesConnection.compactMap { vehicle in
                if let vehicle = vehicle {
                    return .init(name: vehicle.name ?? "")
                }
                return nil
            }
        } else {
            self.vehicles = []
        }
    }
}
