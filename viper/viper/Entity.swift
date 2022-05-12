//
//  Entity.swift
//  viper
//
//  Created by Jonathan Hernandez on 5/11/22.
//

import Foundation

// JUST the Model.
// Will not have a reference to anything else

// Codable is a type alias for the Encodable and Decodable protocols. When you use Codable as a type or a generic constraint, it matches any type that conforms to both protocols.
// Coodable is the a super class we can use to convert our code to JSON and vise-versa ... will be useful when retrieving data from an API
struct User: Codable {
    let name: String
}
