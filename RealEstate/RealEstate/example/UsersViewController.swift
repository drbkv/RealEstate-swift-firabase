import UIKit
import Firebase

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var users: [UserData] = []
    private let tableView = UITableView()
    private let databaseRef = Database.database().reference().child("users")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Registered Users"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loadUsers()
    }
    
    private func loadUsers() {
        databaseRef.observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let userData = snapshot.value as? [String: Any] else {
                print("No user data found")
                return
            }
            self?.users.removeAll()
            for (_, value) in userData {
                if let user = value as? [String: String] {
                    let email = user["email"] ?? ""
                    let password = user["password"] ?? ""
                    let name = user["name"]
                    let surname = user["surname"]
                    let dateOfBirth = user["dateOfBirth"]
                    let userData = UserData(email: email, password: password, name: name, surname: surname, dateOfBirth: dateOfBirth)
                    self?.users.append(userData)
                }
            }
            self?.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = users[indexPath.row]
        
        var userInfo = ""
        userInfo += "Email: \(user.email)\n"
        userInfo += "Name: \(user.name ?? "")\n"
        userInfo += "Surname: \(user.surname ?? "")\n"
        userInfo += "Date of Birth: \(user.dateOfBirth ?? "")"
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = userInfo
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        deleteButton.tag = indexPath.row
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: 60), // Ширина кнопки
            deleteButton.heightAnchor.constraint(equalTo: cell.contentView.heightAnchor), // Высота кнопки равна высоте contentView ячейки
            deleteButton.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor), // Кнопка по центру по вертикали
            deleteButton.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16) // Кнопка справа с отступом
        ])
        
        return cell
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        let user = users[sender.tag]
        deleteUser(withEmail: user.email)
    }
    
    private func deleteUser(withEmail email: String) {
        let userRef = databaseRef.child("users")
        userRef.queryOrdered(byChild: "email").queryEqual(toValue: email).observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let userSnapshot = snapshot.children.allObjects.first as? DataSnapshot,
                  let userId = userSnapshot.key as? String else {
                print("User with email \(email) not found")
                return
            }
            userRef.child(userId).removeValue()
            print("User with email \(email) deleted successfully")
            self?.loadUsers()
        }
    }
}
