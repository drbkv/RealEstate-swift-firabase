//
//  ChatManager.swift
//  RealEstate
//
//  Created by Ramzan on 11.05.2024.
//
import Foundation
import Firebase

class ChatManager {
    static let shared = ChatManager()
    private let database = Database.database().reference().child("messages")

    private init() {}

    func sendMessage(message: Message, completion: @escaping (Error?) -> Void) {
        let messageRef = database.childByAutoId()
        messageRef.setValue(message.toDictionary()) { error, _ in
            completion(error)
        }
    }

    func observeMessages(completion: @escaping ([Message]) -> Void) {
        database.observe(.value) { snapshot in
            var messages: [Message] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let messageDict = snapshot.value as? [String: Any],
                   let message = Message(dictionary: messageDict) {
                    messages.append(message)
                }
            }
            completion(messages)
        }
    }
}
