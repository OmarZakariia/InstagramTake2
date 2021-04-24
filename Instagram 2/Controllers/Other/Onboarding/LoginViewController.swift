//
//  LoginViewController.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /144/21.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius : CGFloat = 8.0
    }
    
    
    //MARK:- TextFields
    private let usernameEmailField : UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) // left view is a bit of buffer left side of the text field so the text does not flush with the actual frame
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        return field
    }()
    
    private let passwordField : UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) // left view is a bit of buffer left side of the text field so the text does not flush with the actual frame
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        return field
    }()
    
    //MARK:- Buttons
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In ", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let createAccountButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create An Account", for: .normal)
        return button
    }()
    
    private let privacyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let termsButton : UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    //MARK:- HeaderView
    
    private let headerView : UIView = {
        let header = UIView()
        header.clipsToBounds = true // so nothing overflows
        
        
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        
        
        
        return header
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        view.backgroundColor = .systemBackground
        
        usernameEmailField.delegate = self
        passwordField.delegate = self
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frames for UIViews
        headerView.frame = CGRect(
            x: 0,
            y: 0.0, // 0.0 so I can eliminate the white area around the image view
            width: view.width, // I will always referene the width like this, for simplicity create an extension file
            height: view.height / 3.0)
        
        configureHeaderView()
        
        usernameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 40,
            width: view.width - 50, // to be centered
            height: 52.0)
        
        passwordField.frame = CGRect(
            x: 25,
            y: usernameEmailField.bottom + 10,
            width: view.width - 50, // to be centered
            height: 52.0)
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.width - 50, // to be centered
            height: 52.0)
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50, // to be centered
            height: 52.0)
        
        termsButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 100 ,
            width: view.width - 20,
            height: 50)
        
        privacyButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 50 ,
            width: view.width - 20,
            height: 50)
        
    }
    
    //MARK:- Functions
    private func addSubviews(){
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(privacyButton)
        view.addSubview(termsButton)
        view.addSubview(headerView)
    }
    
    private func configureHeaderView(){
        // by default I should only have one subview
        guard headerView.subviews.count == 1 else {
            return // if there is nothing else is added except the background, continue
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds // to be the entirety of the headerView
        
        // Add instagram logo
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(
            x: headerView.width / 4.0, // to be centered
            y: view.safeAreaInsets.top,
            width: headerView.width / 2.0,
            height: headerView.height - view.safeAreaInsets.top) // wont overflow
    }
    
    //MARK:- Functions for buttons
    @objc private func didTapLoginButton(){
        passwordField.resignFirstResponder() // to dismiss the keyboard
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        // log in functionality
        var username: String?
        var email: String?
        
        // check to see if user is using email or username
        if usernameEmail.contains("@"), usernameEmail.contains("."){
            // probably will be an email
            email = usernameEmail
        }
        else {
            // username
            username = usernameEmail
        }
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    // user logged in
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    // failed to log in user
                    let alert = UIAlertController(title: "Log in Error", message: "Failed to log you in", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @objc private func didTapTermsButton(){
        
        guard let url = URL(string: "https://www.instagram.com/about/legal/terms/before-january-19-2013/") else {
            // guard let because the URL can be invalid
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
    @objc private func didTapPrivacyButton(){
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton(){
        let vc = RegisterViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
        
    }
}

//MARK:- UITextFieldDelegates and Protocols
extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder() // keyboard pops up
        } else if textField ==  passwordField {
            didTapLoginButton()
        }
        return true
    }
}
