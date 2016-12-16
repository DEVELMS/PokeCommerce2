//
//  KindService.swift
//  PokeCommerce
//
//  Created by Storm on 14/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

struct KindService {
    
    func parseKinds(json: JSON) -> [Kind] {
        
        var kinds = [Kind]()
        
        for (_, kind) in json {
            
            kinds.append(parse(kind: kind.stringValue))
        }
        
        return kinds
    }
    
    private func parse(kind: String) -> Kind {
        
        return Kind(kind: kind)
    }
}
