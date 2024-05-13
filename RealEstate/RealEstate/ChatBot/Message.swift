import Foundation

struct Message {
    let senderId: String
    let senderName: String
    let messageText: String
    let timestamp: TimeInterval

    init(senderId: String, senderName: String, messageText: String, timestamp: TimeInterval) {
        self.senderId = senderId
        self.senderName = senderName
        self.messageText = messageText
        self.timestamp = timestamp
    }

    func toDictionary() -> [String: Any] {
        return [
            "senderId": senderId,
            "senderName": senderName,
            "messageText": messageText,
            "timestamp": timestamp
        ]
    }

    init?(dictionary: [String: Any]) {
        guard let senderId = dictionary["senderId"] as? String,
              let senderName = dictionary["senderName"] as? String,
              let messageText = dictionary["messageText"] as? String,
              let timestamp = dictionary["timestamp"] as? TimeInterval else {
            return nil
        }

        self.senderId = senderId
        self.senderName = senderName
        self.messageText = messageText
        self.timestamp = timestamp
    }
}
