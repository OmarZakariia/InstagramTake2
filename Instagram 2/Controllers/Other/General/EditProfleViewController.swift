//
//  EditProfleViewController.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /144/21.
//

import UIKit

//MARK:- Structs
struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String? // will contain the value of the field
}

final class EditProfleViewController: UIViewController, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        tableView.tableHeaderView = createTableHeaderView()
        
        configureModels()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancelButton))
        
        tableView.dataSource = self
        
        view.addSubview(tableView)
       
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frames
        tableView.frame = view.bounds
    }
    
    //MARK:- TableView
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self , forCellReuseIdentifier: FormTableViewCell.identifier)
        
        return tableView
    }()
    
    
    //MARK:- Variables and Constants
    private var models = [[EditProfileFormModel]]()
    

    
    //MARK:- Private functions
    private func configureModels(){
        // name, username, website, bio
        let section1Labels = ["Name", "Website", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
        
        // email, gender, phone
        let section2Labels = ["Email", "Gender", "Phone"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    
  
 
    
    
    //MARK:- TableView Datasource functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // pull the model out
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
        
    }
    
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        // .integral rounds up to the nearest integer incase I'm using a floating point
        
        // Button to show current user image, tapping it should allow user to change it
        let size = header.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width-size)/2, y: (header.height-size)-2, width: size, height: size))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true // makes the button circular
        profilePhotoButton.layer.cornerRadius = size / 2.0
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        profilePhotoButton.tintColor = .label
        
        return header
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Information"
    }
    
    
    
    //MARK:- Private Functions for button interaction
    
    @objc private func didTapProfilePhotoButton(){
        
    }
    
    @objc private func didTapSaveButton(){
        // save info into the database
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func didTapCancelButton(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePicture(){
        // Show an action sheet to ask the user if they want to import from library or take a photo
        
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change Profile Picture", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Import From Library", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        
        // So it wont crash on iPad
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: false
        )
    }
}

//MARK:- Extension for FormTableViewCellDelegate
extension EditProfleViewController: FormTableViewCellDelegate{
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        //update the model to passback the updated model
        print(updatedModel.value ?? "nil")
    }
    
        
}
