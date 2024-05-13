//import UIKit
//import Firebase
//
//class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    private var messages: [Message] = []
//    private let tableView = UITableView()
//    private let messageInputView = UIView()
//    private let messageTextField = UITextField()
//    private let sendButton = UIButton()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        title = "Чат"
//
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 50 // Set your estimated row height
//
//        setupViews()
//        loadMessages()
//    }
//    private func setupViews() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(tableView)
//        
//        messageInputView.backgroundColor = .lightGray
//        messageInputView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(messageInputView)
//        
//        messageTextField.placeholder = "Введите сообщение..."
//        messageTextField.translatesAutoresizingMaskIntoConstraints = false
//        messageInputView.addSubview(messageTextField)
//        
//        sendButton.setTitle("Отправить", for: .normal)
//        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
//        sendButton.translatesAutoresizingMaskIntoConstraints = false
//        messageInputView.addSubview(sendButton)
//        
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor),
//            
//            messageInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            messageInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            messageInputView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            messageInputView.heightAnchor.constraint(equalToConstant: 50),
//            
//            messageTextField.leadingAnchor.constraint(equalTo: messageInputView.leadingAnchor, constant: 10),
//            messageTextField.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor),
//            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),
//            
//            sendButton.trailingAnchor.constraint(equalTo: messageInputView.trailingAnchor, constant: -10),
//            sendButton.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor),
//        ])
//    }
//
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
//    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
////        let message = messages[indexPath.row]
////        let text = message.senderName == "Bot" ? "🤖 \(message.messageText)" : "\(message.senderName): \(message.messageText)"
////        cell.textLabel?.text = text
////        cell.textLabel?.numberOfLines = 0 // Allow multiple lines for text
////        
////        if message.senderName == "Bot" {
////            cell.textLabel?.textColor = .white // White text color for bot messages
////            cell.backgroundColor = UIColor(red: 0.3, green: 0.5, blue: 0.8, alpha: 1.0) // Light blue background for bot messages
////            cell.textLabel?.textAlignment = .left
////        } else {
////            cell.textLabel?.textColor = .black // Black text color for user messages
////            cell.backgroundColor = .white // White background for user messages
////            cell.textLabel?.textAlignment = .right
////        }
////        
////        return cell
////    }
////    
////    
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let message = messages[indexPath.row]
//
//        if message.senderId == Auth.auth().currentUser?.uid {
//            let text = "\(message.senderName): \(message.messageText)"
//            cell.textLabel?.text = text
//            cell.textLabel?.textAlignment = .right
//            cell.textLabel?.textColor = .black
//            cell.backgroundColor = .white
//        } else if message.senderId == "bot" {
//            cell.textLabel?.text = "🤖 \(message.messageText)"
//            cell.textLabel?.textAlignment = .left
//            cell.textLabel?.textColor = .white
//            cell.backgroundColor = UIColor(red: 0.3, green: 0.5, blue: 0.8, alpha: 1.0)
//        } else {
//            return UITableViewCell() // Return an empty cell for messages from other senders
//        }
//
//        return cell
//    }
//
//    
//    
//    
//    
//
//
//
//    
//    @objc private func sendButtonTapped() {
//        guard let messageText = messageTextField.text, !messageText.isEmpty else {
//            return
//        }
//        sendMessage(messageText)
//        messageTextField.text = ""
//    }
//    
//    private func loadMessages() {
//        let ref = Database.database().reference().child("messages")
//        ref.observe(.childAdded) { [weak self] (snapshot) in
//            guard let messageData = snapshot.value as? [String: Any] else {
//                return
//            }
//            let message = Message(
//                senderId: messageData["senderId"] as? String ?? "",
//                senderName: messageData["senderName"] as? String ?? "Anonymous",
//                messageText: messageData["messageText"] as? String ?? "",
//                timestamp: messageData["timestamp"] as? TimeInterval ?? 0.0
//            )
//            self?.messages.append(message)
//            self?.tableView.reloadData()
//        }
//    }
//    
//    private func sendMessage(_ messageText: String) {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            return
//        }
//        
//        let userMessageRef = Database.database().reference().child("messages").childByAutoId()
//        let userMessageData: [String: Any] = [
//            "senderId": userId,
//            "senderName": Auth.auth().currentUser?.email ?? "Anonymous",
//            "messageText": messageText,
//            "timestamp": ServerValue.timestamp()
//        ]
//        userMessageRef.setValue(userMessageData)
//        
//        let botResponse = processMessage(messageText)
//        let botMessageRef = Database.database().reference().child("messages").childByAutoId()
//        let botMessageData: [String: Any] = [
//            "senderId": "bot",
//            "senderName": "Bot",
//            "messageText": botResponse,
//            "timestamp": ServerValue.timestamp()
//        ]
//        botMessageRef.setValue(botMessageData)
//    }
//    
//    private func processMessage(_ message: String) -> String {
//        let lowercasedMessage = message.lowercased()
//        var maxScore = 0
//        var bestMatch: QAData?
//        
//        for qa in qaData {
//            let question = qa.question.lowercased()
//            let wordsInQuestion = question.components(separatedBy: .whitespaces)
//            let wordsInMessage = lowercasedMessage.components(separatedBy: .whitespaces)
//            var score = 0
//            
//            for word in wordsInMessage {
//                for qWord in wordsInQuestion {
//                    if qWord.contains(word) || word.contains(qWord) {
//                        score += 1
//                    }
//                }
//            }
//            
//            if score > maxScore {
//                maxScore = score
//                bestMatch = qa
//            }
//        }
//        
//        if let bestMatch = bestMatch {
//            return bestMatch.answer
//        } else {
//            return "Извините, я не понял."
//        }
//    }
//}
import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var userMessages: [String: [Message]] = [:]
    private let tableView = UITableView()
    private let messageInputView = UIView()
    private let messageTextField = UITextField()
    private let sendButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Чат"

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80 // Set your estimated row height

        setupViews()
        loadMessages()
    }

    private func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        messageInputView.backgroundColor = .lightGray
        messageInputView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageInputView)

        messageTextField.placeholder = "Введите сообщение..."
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        messageInputView.addSubview(messageTextField)

        sendButton.setTitle("Отправить", for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        messageInputView.addSubview(sendButton)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor),

            messageInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageInputView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageInputView.heightAnchor.constraint(equalToConstant: 50),

            messageTextField.leadingAnchor.constraint(equalTo: messageInputView.leadingAnchor, constant: 10),
            messageTextField.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),

            sendButton.trailingAnchor.constraint(equalTo: messageInputView.trailingAnchor, constant: -10),
            sendButton.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor),
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let userId = Auth.auth().currentUser?.uid else {
            return 0
        }
        return userMessages[userId]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userId = Auth.auth().currentUser?.uid, let userMessages = userMessages[userId] else {
            return UITableViewCell()
        }
        let message = userMessages[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0 // Allow multiple lines for text

        if message.senderId == userId {
            let text = "\(message.senderName): \(message.messageText)"
            cell.textLabel?.text = text
            cell.textLabel?.textAlignment = .right
            cell.textLabel?.textColor = .black
            cell.backgroundColor = .white
        } else if message.senderId == "bot" {
            cell.textLabel?.text = "🤖 \(message.messageText)"
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.textColor = .white
            cell.backgroundColor = UIColor(red: 0.3, green: 0.5, blue: 0.8, alpha: 1.0)
        }

        return cell
    }

    @objc private func sendButtonTapped() {
        guard let messageText = messageTextField.text, !messageText.isEmpty else {
            return
        }
        sendMessage(messageText)
        messageTextField.text = ""
    }

    private func loadMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded) { [weak self] (snapshot) in
            guard let messageData = snapshot.value as? [String: Any] else {
                return
            }
            let message = Message(
                senderId: messageData["senderId"] as? String ?? "",
                senderName: messageData["senderName"] as? String ?? "Anonymous",
                messageText: messageData["messageText"] as? String ?? "",
                timestamp: messageData["timestamp"] as? TimeInterval ?? 0.0
            )
            if let userId = Auth.auth().currentUser?.uid {
                if self?.userMessages[userId] == nil {
                    self?.userMessages[userId] = []
                }
                self?.userMessages[userId]?.append(message)
                self?.tableView.reloadData()
            }
        }
    }

    private func sendMessage(_ messageText: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        let userMessageRef = Database.database().reference().child("messages").childByAutoId()
        let userMessageData: [String: Any] = [
            "senderId": userId,
            "senderName": Auth.auth().currentUser?.email ?? "Anonymous",
            "messageText": messageText,
            "timestamp": ServerValue.timestamp()
        ]
        userMessageRef.setValue(userMessageData)

        let botResponse = processMessage(messageText)
        let botMessageRef = Database.database().reference().child("messages").childByAutoId()
        let botMessageData: [String: Any] = [
            "senderId": "bot",
            "senderName": "Bot",
            "messageText": botResponse,
            "timestamp": ServerValue.timestamp()
        ]
        botMessageRef.setValue(botMessageData)
    }

    private func processMessage(_ message: String) -> String {
        let lowercasedMessage = message.lowercased()
        var maxScore = 0
        var bestMatch: QAData?

        for qa in qaData {
            let question = qa.question.lowercased()
            let wordsInQuestion = question.components(separatedBy: .whitespaces)
            let wordsInMessage = lowercasedMessage.components(separatedBy: .whitespaces)
            var score = 0

            for word in wordsInMessage {
                for qWord in wordsInQuestion {
                    if qWord.contains(word) || word.contains(qWord) {
                        score += 1
                    }
                }
            }

            if score > maxScore {
                maxScore = score
                bestMatch = qa
            }
        }

        if let bestMatch = bestMatch {
            return bestMatch.answer
        } else {
            return "Извините, я не понял."
        }
    }
}
