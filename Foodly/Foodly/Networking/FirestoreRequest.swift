//
//  FirestoreRequest.swift
//  Foodly
//
//  Created by Decagon on 5.6.21.
//

import Foundation
import FirebaseFirestore

protocol FirestoreRequest {
    var operations: Operations { get }
    var documentReference: DocumentReference? { get }
    var collectionReference: CollectionReference? { get }
    var baseCollectionReference: DocumentReference? { get }
}
