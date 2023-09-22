//
//  MainEntity.swift
//  Currency Converter
//
//  Created by Misael on 22/09/23.
//

import Foundation

struct Rates: Codable {
    let success: Bool?
    let timestamp: Int?
    let base: String?
    let date: String?
    let rates: RatesObject?
    let error: ErrorRate?
}

struct RatesObject: Codable {
    let usd: Double?
    let eur: Double?
    let mxn: Double?
    let cad: Double?
    let jpy: Double?
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
        case mxn = "MXN"
        case cad = "CAD"
        case jpy = "JPY"
    }
}

struct ErrorRate: Codable {
    let code: Int?
    let info: String?
}
