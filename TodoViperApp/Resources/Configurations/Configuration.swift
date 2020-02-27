//
//  Configuration.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

struct ConfigurationValues {
   
    struct Config: Decodable {
        let baseURL: String
    }
    
    static func get() -> Config {
        
        let path = Bundle.main.url(forResource: "Configuration", withExtension: "plist")
        
        guard let url = path else {
            fatalError("Could not find Configuration.plist in you Bundle")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            return try decoder.decode(Config.self, from: data)
        } catch let error {
            fatalError(error.localizedDescription)
        }
        
    }
}
