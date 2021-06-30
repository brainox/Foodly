//
//  RestaurantApi.swift
//  Foodly
//
//  Created by Decagon on 21.6.21.
//

import Foundation
import FirebaseFirestore

enum RestaurantAPI {
    case getRestaurants
}


extension RestaurantAPI: FirestoreRequest {
    var operations: Operations {
        switch self {
        case .getRestaurants:
            return .read
        }
    }
    
    var baseCollectionReference: DocumentReference? {
        return Firestore.firestore().collection(Collection.restaurants.identifier).document()
    }
    
    var documentReference: DocumentReference? {
        switch self {
        case .getRestaurants:
            return baseCollectionReference?.collection(Collection.restaurants.identifier).document()
        }
    }
    
    var collectionReference: CollectionReference? {
        switch self {
        case .getRestaurants:
            return Firestore.firestore().collection(Collection.restaurants.identifier)
            
        }
    }
    
}
