//
//  ViewController.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /144/21.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    //MARK:- TableView variable
    private let tableView: UITableView = {
        let tableView = UITableView()
        // gonna add custom cells
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frames
        tableView.frame = view.bounds
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


//MARK:- Extension UITableViewDelegates and DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
        return UITableViewCell()
    }
}
