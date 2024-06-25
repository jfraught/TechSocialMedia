//
//  LoginViewController.swift
//  TechSocialMedia
//
//  Created by Jordan Fraughton on 6/25/24.
//

import UIKit

class LoginViewController: UIViewController {
    let authenticationController = AuthenticationController()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInButtonTapped(_ sender: UIButton) {
        guard
            let email = emailTextField.text,
            !email.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty
        else { return }
        
        Task {
            do {
                let success = try await authenticationController.signIn(email: email, password: password)
                if success {
                    let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "userSignedIn")
                    let viewControllers = [viewController]
                    self.navigationController?.setViewControllers(viewControllers, animated: true)
                }
            } catch {
                print(error)
                errorLabel.text = "Invalid Username or Password"
            }
        }
    }
}

