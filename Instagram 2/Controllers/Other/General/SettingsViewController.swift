//
//  SettingsViewController.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /144/21.
//

import UIKit
/// View controller to show user settings
final class SettingsViewController: UIViewController {
    
    //MARK:- Structs
    struct SettingCellModel {
        let title : String
        let handler : (()->Void)
    }
    //MARK:- Variables and constants
    private var data = [[SettingCellModel]]()// 2D dimensional array because I am gonna have multiple sections
    
    //MARK:- TableView Var
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped) // grouped will allow me to get the look of that default look of UITableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureDataModel()
    }
    override func viewDidLayoutSubviews() {
        // viewDidLayoutSubviews gets called after the other subviews are laid out
        super.viewDidLayoutSubviews()
        // assign frames
        tableView.frame = view.bounds
    }
    //MARK:- Private functions
    private func configureDataModel(){
        let section = [
            SettingCellModel(title: "Log Out"){ [weak self] in
                // weak self to ensure not to cause a memory leak because I am referencing self
                self?.didTapLogOut()
                
            }
        ]
        data.append(section)
    }
    
    private func didTapLogOut(){
        // show an action sheet for the user whether they want to log out or not and then log the user out
        let actionSheet = UIAlertController(title: "Log Out?", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            // I used _ in the closure parameter because I want to disregaurd the results
            AuthManager.shared.logout(completion: { success in
                DispatchQueue.main.async {
                    if success {
                        // present log in view controller
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true) {
                            // switch back to home tab rather than settings
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                            
                            
                        }
                    }
                    else {
                        // error occured
                        fatalError("Could not log out user")
                    }
                }
                
            })
        }))
        
        // so the action sheet wont crash in iPad because it doesnt know how to behave
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
    
        present(actionSheet, animated: true)
    }
    
    
}

//MARK:- UITableViewDelegate and DataSource Extension
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle Cell Selection
        data[indexPath.row][indexPath.section].handler()
        
    }
}
