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

    // UserPosts array
    private var userPost = [UserPost]()
    
    
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
//        return userPost.count
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.configure(debug: "test")
        
        //        let model = userPost[indexPath.row]
//        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // get the model and open PostVc
        
//        let model = userPost[indexPath.row] //should pass the model to the post vc
        let vc = PostViewController(model: nil)
        vc.title = "Post"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader  else {
            // footer r
            return UICollectionReusableView()
        }
        if indexPath.section == 1 {
            // tabs header
            let tabsControlHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTablsCollectionReusableView.identifier, for: indexPath) as! ProfileTablsCollectionReusableView
            
            tabsControlHeader.delegate = self
            
            return tabsControlHeader
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderReusableView.identifier, for: indexPath) as! ProfileInfoHeaderReusableView
        
        profileHeader.delegate = self
        
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height/3)
        }
//        return .zero // this returns zero height and zero width
        
        // Size of sections tabs 
        return CGSize(width: collectionView.width, height: 50)
    }
}

//MARK:- ProfileInfoHeaderReusableViewDelegate
extension ProfileViewController: ProfileInfoHeaderReusableViewDelegate{
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderReusableView) {
        // scroll to the posts section
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderReusableView) {
        // show users followers
        let vc = ListViewController(data: ["Zakaria", "Zeks", "Ziko"])
        vc.title = "Followrs"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderReusableView) {
        // show users following
        let vc = ListViewController(data: ["Zakaria", "Zeks", "Ziko"])
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapEditProfileButtonButton(_ header: ProfileInfoHeaderReusableView) {
        // show edit profile vc
        let vc = EditProfleViewController()
        vc.title = "Edit Profile"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    
}

//MARK:- ProfileTabsCollectionReusableViewDelegate
extension ProfileViewController: ProfileTablsCollectionReusableViewDelegate{
    func didTapGridButtonTab() {
        // Reload collection view with data
    }
    
    func didTapTaggedButtonTab() {
        // Reload collection view with data 
    }
    
    
}
