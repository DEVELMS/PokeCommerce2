//
//  Application.swift
//  PokeCommerce
//
//  Created by Storm on 14/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

final class Application {
    
    // Can't init is singleton
    private init() { }
    
    //MARK: Shared Instance
    
    static let sharedInstance: Application = Application()
    
    //MARK: Local Variable
    var sections = [Section]()
}
