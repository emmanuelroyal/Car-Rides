//
//  YourTrips.swift
//  Car-Rides
//
//  Created by Decagon on 8/11/21.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth

enum TripsApi {
    case getTrips
    case createTrips(items: RequestParameter)
}

extension TripsApi: FirestoreRequest {
    
    var collectionReference: CollectionReference? {
        switch self {
        case .getTrips:
            guard let userID = Auth.auth().currentUser?.uid else { return nil }
            return Firestore.firestore().collection(Collection.users.identifier).document("\(userID)").collection(Collection.userTrips.identifier)
        case .createTrips:
            guard let userID = Auth.auth().currentUser?.uid else { return nil }
            return Firestore.firestore().collection(Collection.users.identifier).document("\(userID)").collection(Collection.userTrips.identifier)
        }
    }
    
    var baseCollectionReference: DocumentReference? {
        return Firestore.firestore().collection(Collection.userProfile.identifier).document()
    }
    
    var tasks: Tasks {
        switch self {
        case .getTrips:
            return .read
        case .createTrips(let trip):
            return .create(documentData: trip.asParameter)
        }
    }
    var documentReference: DocumentReference? {
        switch self {
        case .getTrips:
            return baseCollectionReference
        case .createTrips:
            guard let userID = Auth.auth().currentUser?.uid else { return nil }
            return Firestore.firestore().collection(Collection.users.identifier).document("\(userID)")
        }
    }
    var collectionReferences: Query? {
        return Firestore.firestore().collection(Collection.userProfile.identifier).whereField("capital", isEqualTo: true)
    }
}

