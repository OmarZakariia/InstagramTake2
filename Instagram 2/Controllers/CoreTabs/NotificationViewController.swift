//
//  NotificationViewController.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /144/21.
//

import UIKit

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- TableView Var
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FollowEventTableViewCell.self, forCellReuseIdentifier:
                            FollowEventTableViewCell.identifier)
        tableView.register(LikeEventTableViewCell.self, forCellReuseIdentifier: LikeEventTableViewCell.identifier)
       // tableView.isHidden = true // hidden by default, because I wont have content as soon as app launched and I should fetch them
        return tableView
    }()
    
    //MARK:- Subviews
    private lazy var noNotificationView = NoNotificationsView() // lazy word only instantiates this once we call it

    private var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        
        return spinner
    }()
    
//MARK:- Overrident functions
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Notifications"
        
        view.addSubview(spinner)
       // spinner.startAnimating()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    //MARK:- Private functions
    private func addNotificationView(){
        // using this because I am gonna lay it out if I know that I know that I have no notifications the second I call this property (lazy var) it instantiates it
        noNotificationView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.width/2,
            height: view.width/2)
        noNotificationView.center = view.center
        tableView.isHidden = true
        view.addSubview(tableView)
    }

//MARK:- TableView Delegate and Datasource functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
