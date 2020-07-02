//
//  APIServices.swift
//  Programmatically
//
//  Created by Windy on 18/06/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import UIKit

struct Covid: Decodable {
    
    let global: Global
    let countries: [Country]
    
    enum CodingKeys: String, CodingKey {
        case countries = "Countries"
        case global = "Global"
    }
    
}

struct Global: Decodable {
    let totalInfected: Int
    let totalRecovered: Int
    let totalDeath: Int
    
    enum CodingKeys: String, CodingKey {
        case totalInfected = "TotalConfirmed"
        case totalRecovered = "TotalRecovered"
        case totalDeath = "TotalDeaths"
    }
}

struct Country: Decodable {
    let country: String
    let newConfirmed: Int
    let totalConfirmed: Int
    let totalDeath: Int
    let totalRecovered: Int
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case totalConfirmed = "TotalConfirmed"
        case totalDeath = "TotalDeaths"
        case totalRecovered = "TotalRecovered"
        case newConfirmed = "NewConfirmed"
    }
}

class ApiServices {
    
    func fetchRequest(completion: @escaping (Covid) -> ()) {

        guard let url = URL(string: "https://api.covid19api.com/summary") else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    let covids = try JSONDecoder().decode(Covid.self, from: data)

                    DispatchQueue.main.async {
                        completion(covids)
                    }

                } catch let err {
                    print(err)
                }
            }
            
        }.resume()
    }
    
}
