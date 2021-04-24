//
//  ViewController.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /144/21.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
//        
//        do{
//            try Auth.auth().signOut()
//        }
//        catch {
//            print("Failed to sign out")
//        }
    }
    
    //MARK:- Functions
    private func handleNotAuthenticated(){
        if Auth.auth().currentUser == nil{
            // show login view controller
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen // so the user cant swipe it away
            present(loginVC, animated: true)
        }
    }


}

