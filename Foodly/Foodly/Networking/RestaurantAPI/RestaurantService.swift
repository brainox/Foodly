//
//  RestaurantService.swift
//  Foodly
//
//  Created by Decagon on 21.6.21.
//

import Foundation

struct RestaurantService {
    let router = Router<RestaurantAPI>()
    
    func getRestaurants(completion: @escaping NetworkRouterCompletion) {
        router.request(.getRestaurants, completion: completion)
    }
    
}
