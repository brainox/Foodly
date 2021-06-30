//
//  DeliveryPersonApi.swift
//  Foodly
//
//  Created by Decagon on 22.6.21.
//

import Foundation
import FirebaseFirestore

enum DeliveryPersonApi {
    case getDeliveryPerson
}

extension DeliveryPersonApi: FirestoreRequest {
    var operations: Operations {
        switch self {
        case .getDeliveryPerson:
            return .read
        }
    }
    
    var baseCollectionReference: DocumentReference? {
        return Firestore.firestore().collection(Collection.deliveryPerson.identifier).document()
    }

    var documentReference: DocumentReference? {
        switch self {
        case .getDeliveryPerson:
            return baseCollectionReference
        }
    }
    
    var collectionReference: CollectionReference? {
        switch self {
        case .getDeliveryPerson:
            return Firestore.firestore().collection(Collection.deliveryPerson.identifier)
        }
    }
    
}
