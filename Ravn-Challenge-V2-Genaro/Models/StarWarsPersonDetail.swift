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
    
    var details: [PersonDetail] {
        var personDetails = [PersonDetail?]()
        personDetails.append(PersonDetail.getDetail(.eyes, value: eyeColor))
        personDetails.append(PersonDetail.getDetail(.hair, value: hairColor))
        personDetails.append(PersonDetail.getDetail(.skin, value: skinColor))
        personDetails.append(PersonDetail.getDetail(.birth, value: birthYear))
        return personDetails.compactMap({ $0 })
    }
 
    struct Vehicle: Identifiable {
        let id = UUID()
        let name: String
    }
    
    init() {
        self.name = ""
        self.eyeColor = nil
        self.hairColor = nil
        self.skinColor = nil
        self.birthYear = nil
        self.vehicles = []
    }
    
    init(name: String, eyeColor: String?, hairColor: String?, skinColor: String?, birthYear: String?, vehicles: [StarWarsPersonDetail.Vehicle]) {
        self.name = name
        self.eyeColor = eyeColor
        self.hairColor = hairColor
        self.skinColor = skinColor
        self.birthYear = birthYear
        self.vehicles = vehicles
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

// struct used in PeopleDetailView section
struct PersonDetail: Identifiable {
    let id = UUID()
    let type: String
    let name: String
    
    private init(type: String, name: String) {
        self.type = type
        self.name = name
    }

    static func getDetail(_ type: PersonDetailType, value: String?) -> PersonDetail? {
        if let value = value {
            return PersonDetail(type: type.name, name: value)
        }
        return nil
    }
    
    enum PersonDetailType {
        case eyes
        case hair
        case skin
        case birth
        
        var name: String {
            switch self {
            case .birth:
                return "Birth Year"
            case .skin:
                return "Skin Color"
            case .hair:
                return "Hair Color"
            case .eyes:
                return "Eye Color"
            }
        }
    }
}
