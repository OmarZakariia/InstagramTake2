//
//  ProfileInfoHeaderReusableView.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /274/21.
//

import UIKit

protocol ProfileInfoHeaderReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderReusableView)
    func profileHeaderDidTapEditProfileButtonButton(_ header: ProfileInfoHeaderReusableView)
}

final class ProfileInfoHeaderReusableView: UICollectionReusableView {
    
    public weak var delegate: ProfileInfoHeaderReusableViewDelegate?// this is how I get the button tap interactions
    
    static let identifier = "ProfileInfoHeaderReusableView"
    
    // Subviews
    private let profilPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        
        
        return button
    }()
    
    private let editProfileButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Zeks"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "First Account"
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addButtonActions()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // assign frames
        let profilePhotoSize = width/4
        profilPhotoImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: profilePhotoSize,
            height: profilePhotoSize).integral
        
        profilPhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let buttonHeight = profilePhotoSize/2.0
        let countButtonWidth = (width-10-profilePhotoSize)/3 // divide by 3 since I have 3 buttons
        
        postsButton.frame = CGRect(
            x: profilPhotoImageView.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight).integral
        
        followersButton.frame = CGRect(
            x: postsButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight).integral
        
        followingButton.frame = CGRect(
            x: followersButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight).integral
        
        editProfileButton.frame = CGRect(
            x: profilPhotoImageView.right,
            y: 5 + buttonHeight,
            width: countButtonWidth*3, // *3 because the entirety of the view
            height: buttonHeight).integral
        
        nameLabel.frame = CGRect(
            x: 5,
            y: 5 + profilPhotoImageView.bottom,
            width: width-10,
            height: 50).integral
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(
            x: 5,
            y: 5 + nameLabel.bottom,
            width: width-10,
            height: bioLabelSize.height).integral
    }
    
    //MARK:- Private Functions
    private func addSubviews(){
        // order does not matter, because I will layout the subviews
        addSubview(profilPhotoImageView)
        addSubview(postsButton)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    private func addButtonActions(){
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    //MARK:- Button Actiosn
    @objc private func didTapFollowersButton(){
        delegate?.profileHeaderDidTapFollowersButton(self)
        
    }
    @objc private func didTapFollowingButton(){
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    @objc private func didTapPostsButton(){
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    @objc private func didTapEditProfileButton(){
        delegate?.profileHeaderDidTapEditProfileButtonButton(self)
    }
}
