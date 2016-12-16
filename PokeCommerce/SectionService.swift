//
//  SectionService.swift
//  PokeCommerce
//
//  Created by DEVELMS on 14/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

struct SectionService {
    
    func parseSections(json: JSON) -> [Section] {
        
        var sections = [Section]()
        
        for (_, section) in json {
            
            sections.append(parseSection(json: section))
        }
        
        return sections
    }
    
    private func parseSection(json: JSON) -> Section {
        
        let pokemonService = PokemonService()
        
        let id = json["id"].intValue
        let price = json["price"].numberValue
        let name = json["section"].stringValue
        let pokemons = pokemonService.parsePokemons(json: json["pokemons"])
        
        return Section(id: id, price: price, name: name, pokemons: pokemons)
    }
}
