//
//  ProfileViewController.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /144/21.
//

import UIKit


/// Profile View Controller
final class ProfileViewController: UIViewController {
    
    //MARK:- CollectionView Variable
    private var collectionView: UICollectionView? // optional so I can instantiate it later and so I can be able to create the layout and reference things on self

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureNavigationBar()
        
        // Collectionview
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        let size = (view.width-4)/3
        layout.itemSize = CGSize(width: size, height: size) // to be squared cells
        layout.minimumLineSpacing = 1 // this line and the one after are responsible for getting 3 columns
        layout.minimumInteritemSpacing = 1


        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .red
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        // Cell
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)

        // Header
        collectionView?.register(ProfileInfoHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderReusableView.identifier)

        collectionView?.register(ProfileTablsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTablsCollectionReusableView.identifier)
        
        
        guard let collectionView = collectionView else {
            // guard let because its an optional
            return
        }
        view.addSubview(collectionView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    //MARK:- Private functions
    private func configureNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettingsButton))
    }
    
   @objc private func didTapSettingsButton(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        // push vc
        navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK:- Extension for UICollectionViewDelegate, DataSource and DelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
     return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.configure(debug: "test")
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader  else {
            // footer r
            return UICollectionReusableView()
        }
        if indexPath.section == 1 {
            // tabs header
            let tabsControlHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTablsCollectionReusableView.identifier, for: indexPath) as! ProfileTablsCollectionReusableView
            
            return tabsControlHeader
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderReusableView.identifier, for: indexPath) as! ProfileInfoHeaderReusableView
        
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height/3)
        }
//        return .zero // this returns zero height and zero width
        
        // Size of sections tabs 
        return CGSize(width: collectionView.width, height: 65)
    }
}
