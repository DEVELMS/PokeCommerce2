//
//  BaseUrl.swift
//  Foodsage
//
//  Created by Calebe Emerick on 30/06/16.
//  Copyright © 2016 EstrategiaMKTDigital. All rights reserved.
//

import Foundation

protocol URLS { }

extension URLS {
    
    func getUrl(_ type: EndPoint) -> String {
        
        return type.url
    }
    
    fileprivate func getUrlWithFilters(_ url: String, filters: [(name: String, value: Any)]) -> String {

        var newUrl = url
        
        for (index, filter) in filters.enumerated() {
            
            var separator = "?"
            
            if index > 0 {
                
                separator = "&"
            }
            
            newUrl = "\(newUrl)\(separator)\(filter.name)=\(filter.value)"
        }
        
        return newUrl
    }
}

enum EndPoint {
    
    case application
    
    var url: String {
    
        switch self {
        case .application: return "https://private-a37d8e-pokestorm.apiary-mock.com/pokemons"
        }
    }
}
