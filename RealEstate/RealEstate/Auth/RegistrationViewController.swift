import UIKit

class RegistrationViewController: UIViewController {
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
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
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // Добавляем свойство для хранения данных пользователя
    var userData: UserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let darkGreenColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1.0)

        let registerButton = UIButton(type: .system)
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = darkGreenColor // Задаем темно-зеленый цвет кнопке
        registerButton.setTitleColor(.white, for: .normal) // Устанавливаем белый цвет текста на кнопке
        registerButton.addTarget(self, action: #selector(registerButtonTapped(_:)), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])



    }
    
    @objc func registerButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        // Проверка формата email
        if !isValidEmail(email) {
            let alert = UIAlertController(title: "Ошибка", message: "Введите корректный email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        let registrationManager = RegistrationManager.shared
        registrationManager.registerUser(email: email, password: password) { [weak self] error in
            if let error = error {
                // Handle registration error
                print("Registration error: \(error.localizedDescription)")
            } else {
                // Registration successful, show success message and navigate to LoginViewController
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Успешная регистрация", message: "Вы успешно зарегистрировались", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        // Закрытие RegistrationViewController
                        self?.dismiss(animated: true) {
                            // Открытие LoginViewController после закрытия RegistrationViewController
                            let loginVC = LoginViewController() // замените на ваш класс LoginViewController
                            self?.present(loginVC, animated: true, completion: nil)
                        }
                    }))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        // Простая проверка формата email с помощью регулярного выражения
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
