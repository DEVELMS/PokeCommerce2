//
//  Protocols.swift
//  Foodsage
//
//  Created by Calebe Emerick on 23/05/16.
//  Copyright © 2016 EstrategiaMKTDigital. All rights reserved.
//

protocol Requesting {
    
    func APIRequest(method: HTTPMethod, endPoint: EndPoint, success: @escaping (Any) -> Void, failure: @escaping (Int) -> Void)
}
