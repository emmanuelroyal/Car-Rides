//
//  MessagesService.swift
//  Car-Rides
//
//  Created by Decagon on 8/12/21.
//

import Foundation
struct MessagesService {
    let router = Router<MessagesApi>()
    
    func getMessages(completion: @escaping NetworkRouterCompletion) {
        router.request(.getMessages, completion: completion)
    }
    
    func createMessage(docId: String, message: Message, completion: @escaping NetworkRouterCompletion) {
        router.request(.createMessages(items: message, id: docId), completion: completion)
    }
    
    func getOrderedMessages(docId: String, completion: @escaping NetworkRouterCompletion) {
        router.request(.getOrderMessages(id: docId), completion: completion)
     }
    func createDriverMessage( message: Message, completion: @escaping NetworkRouterCompletion) {
        router.request(.createDriverMessage(items: message), completion: completion)
    }
}

