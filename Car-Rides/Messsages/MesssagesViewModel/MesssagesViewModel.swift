//
//  MesssagesViewModel.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import Foundation
class MessagesViewModel {
    var messageArray = [MessageTable]()
    var notifyCompletion: (() -> Void)?
    
    func get() {
        self.messageArray.removeAll()
        let getMessages = MessagesService()
        getMessages.getMessages {(result) in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let result):
                result?.documents.forEach({ (doc) in
                    let data = doc.data()
                    if let sender = data["title"] as? String, let time = data["time"] as? String,
                       let opened = data["opened"] as? String, let body = data["body"] as? String {
                        let message = MessageTable(title: sender, body: body, time: time, opened: opened, messageId: doc.documentID)
                        self.messageArray.append(message)
                    }
                })
                self.notifyCompletion?()
            }
        }
    }
}

