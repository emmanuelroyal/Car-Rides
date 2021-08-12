//
//  MessagesAPI.swift
//  Car-Rides
//
//  Created by Decagon on 8/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

enum MessagesApi {
    case getMessages
    case getOrderMessages(id: String)
    case createMessages(items: RequestParameter, id: String)
    case createDriverMessage(items: RequestParameter)
}

extension MessagesApi: FirestoreRequest {
    
    var collectionReference: CollectionReference? {
        switch self {
        case .getMessages:
            guard let userID = Auth.auth().currentUser?.uid else { return nil }
            return Firestore.firestore().collection(Collection.users.identifier).document("\(userID)").collection(Collection.userMessages.identifier)
        case .createMessages(let id, _):
            guard let userID = Auth.auth().currentUser?.uid else { return nil }
            return Firestore.firestore().collection(Collection.users.identifier).document("\(userID)").collection(Collection.userMessages.identifier).document("\(id)").collection(Collection.userMessagesChat.identifier)
        case .getOrderMessages(let id):
            guard let userID = Auth.auth().currentUser?.uid else { return nil }
            return Firestore.firestore().collection(Collection.users.identifier).document("\(userID)").collection(Collection.userMessages.identifier).document("\(id)").collection(Collection.userMessagesChat.identifier)
        case .createDriverMessage:
            guard let userID = Auth.auth().currentUser?.uid else { return nil }
            return Firestore.firestore().collection(Collection.users.identifier).document("\(userID)").collection(Collection.userMessages.identifier)
        }
    }
    
    var baseCollectionReference: DocumentReference? {
        return Firestore.firestore().collection(Collection.userProfile.identifier).document()
    }
    
    var tasks: Tasks {
        switch self {
        case .getMessages:
            return .read
        case .createMessages(let message, _):
            return .create(documentData: message.asParameter)
        case .getOrderMessages(_):
            return .readOrdered
        case .createDriverMessage(let message):
            return .create(documentData: message.asParameter)
        }
    }
    var documentReference: DocumentReference? {
        switch self {
        case .getMessages:
            return baseCollectionReference
        case .createMessages(let id, _) :
            guard let userID = Auth.auth().currentUser?.uid else { return nil }
            return Firestore.firestore().collection(Collection.users.identifier).document("\(userID)").collection(Collection.userMessages.identifier).document("\(id)")
            
        case .getOrderMessages(id: _):
            return baseCollectionReference
        case .createDriverMessage(items: _):
            return baseCollectionReference
        }
    }
    var collectionReferences: Query? {
        return Firestore.firestore().collection(Collection.userProfile.identifier).whereField("capital", isEqualTo: true)
    }
}


