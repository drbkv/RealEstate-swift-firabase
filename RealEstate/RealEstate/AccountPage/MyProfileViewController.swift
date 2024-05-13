

import UIKit
import Firebase

class MyProfileViewController: UIViewController {
    var userData: UserData?

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEnabled = false // Disable editing initially
        return textField
    }()

    let surnameLabel: UILabel = {
        let label = UILabel()
        label.text = "Surname:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your surname"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEnabled = false // Disable editing initially
        return textField
    }()

    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEnabled = false // Disable editing initially
        return textField
    }()

    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Number:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your phone number"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEnabled = false // Disable editing initially
        return textField
    }()

    let dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.text = "Date of Birth:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateOfBirthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your date of birth"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEnabled = false // Disable editing initially
        return textField
    }()

    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true // Hidden initially
        return button
    }()


    
    let myListingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Мои объявления", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.7, blue: 0.0, alpha: 1.0) // Dark green color
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(myListingsButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LogOut", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.6, green: 0.0, blue: 0.0, alpha: 1.0) // Lighter red color
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logoutButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupViews()
        loadUserData()
    }


    
    func setupViews() {
        let topStackView = UIStackView(arrangedSubviews: [editButton, saveButton])
        topStackView.axis = .horizontal
        topStackView.spacing = 10
        topStackView.translatesAutoresizingMaskIntoConstraints = false

        let nameLabelStackView = UIStackView(arrangedSubviews: [nameLabel, topStackView])
        nameLabelStackView.axis = .horizontal
        nameLabelStackView.spacing = 10
        nameLabelStackView.translatesAutoresizingMaskIntoConstraints = false

        let inputFieldsStackView = UIStackView(arrangedSubviews: [nameTextField, surnameLabel, surnameTextField, emailLabel, emailTextField, phoneNumberLabel, phoneNumberTextField, dateOfBirthLabel, dateOfBirthTextField])
        inputFieldsStackView.axis = .vertical
        inputFieldsStackView.spacing = 10
        inputFieldsStackView.translatesAutoresizingMaskIntoConstraints = false

        // Add a border to each text field
        [nameTextField, surnameTextField, emailTextField, phoneNumberTextField, dateOfBirthTextField].forEach { textField in
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = 5
        }

        let mainStackView = UIStackView(arrangedSubviews: [nameLabelStackView, inputFieldsStackView, myListingsButton, logoutButton])
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }




    
    func loadUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        let ref = Database.database().reference().child("users").child(userId)
        ref.observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let self = self, let userData = snapshot.value as? [String: Any] else {
                return
            }

            self.nameTextField.text = userData["name"] as? String ?? ""
            self.surnameTextField.text = userData["surname"] as? String ?? ""
            self.emailTextField.text = Auth.auth().currentUser?.email ?? ""
            self.phoneNumberTextField.text = userData["phoneNumber"] as? String ?? ""
            self.dateOfBirthTextField.text = userData["dateOfBirth"] as? String ?? ""
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserData()
    }



    @objc func editButtonTapped(_ sender: UIButton) {
        nameTextField.isEnabled = true
        surnameTextField.isEnabled = true
        phoneNumberTextField.isEnabled = true
        dateOfBirthTextField.isEnabled = true

        editButton.isHidden = true
        saveButton.isHidden = false
    }

    @objc func saveButtonTapped(_ sender: UIButton) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        let userData: [String: Any] = [
            "name": nameTextField.text ?? "",
            "surname": surnameTextField.text ?? "",
            "email": emailTextField.text ?? "",
            "phoneNumber": phoneNumberTextField.text ?? "",
            "dateOfBirth": dateOfBirthTextField.text ?? ""
        ]

        let ref = Database.database().reference().child("users").child(userId)
        ref.setValue(userData) { (error, ref) in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            } else {
                print("User data saved successfully")
                self.editButton.isHidden = false
                self.saveButton.isHidden = true

                self.nameTextField.isEnabled = false
                self.surnameTextField.isEnabled = false
                self.emailTextField.isEnabled = false
                self.phoneNumberTextField.isEnabled = false
                self.dateOfBirthTextField.isEnabled = false
            }
        }
    }

    @objc func myListingsButtonTapped(_ sender: UIButton) {
        let userListingsVC = UserListingsViewController()
        navigationController?.pushViewController(userListingsVC, animated: true)
    }

    @objc func logoutButtonTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            let loginVC = LoginViewController()
            navigationController?.setViewControllers([loginVC], animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}
