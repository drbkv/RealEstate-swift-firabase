import UIKit
import Firebase

class LoginViewController: UIViewController {

    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // Property to store user data
    var userData: UserData?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupViews()
    }

    func setupViews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)

        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            emailTextField.widthAnchor.constraint(equalToConstant: 250),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),

            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
        ])

        let loginButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Login", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0) // Dark green color
            button.layer.cornerRadius = 5
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
            return button
        }()

        view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: 250),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        let registrationButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Registration", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(registrationButtonTapped(_:)), for: .touchUpInside)
            return button
        }()

        view.addSubview(registrationButton)

        NSLayoutConstraint.activate([
            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
        ])
    }

    @objc func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        // Create a UserData object based on the data from the text fields
        userData = UserData(email: email, password: password, name: "", surname: "", dateOfBirth: "")
           
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                print("Login error: \(error)")
                let alert = UIAlertController(title: "Ошибка", message: "Введите корректные данные", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            // Successful login
            let mainTabBarController = MainTabBarController()
            if let profileViewController = mainTabBarController.viewControllers?.first as? MyProfileViewController {
                // Pass the userData to MyProfileViewController
                profileViewController.userData = self.userData
            }
            UIApplication.shared.windows.first?.rootViewController = mainTabBarController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }

    @objc func registrationButtonTapped(_ sender: UIButton) {
        let registrationVC = RegistrationViewController()
        let navController = UINavigationController(rootViewController: registrationVC)
        present(navController, animated: true, completion: nil)
    }
}
