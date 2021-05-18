//
//  UserFollowTableViewCell.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /145/21.
//

import UIKit

//MARK:- Protocol
protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model : UserRelationship)
}

//MARK:- Structs and Enums
enum FollowState {
    case following, not_following
}
struct UserRelationship {
    let username: String
    let name: String
    let type : FollowState
}

class UserFollowTableViewCell: UITableViewCell {

    //MARK:- Variables and Constants
    static let identifier = "UserFollowTableViewCell"
    
    public weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelationship?

    
    //MARK:- Subviews
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Zeks"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        
        
        return label
    }()
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "@Zeks"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    private let followButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
    
    //MARK:- Initializers and overriden methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(followButton)
        selectionStyle = .none
        
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // assign frames
        profilePhotoImageView.frame = CGRect(
            x: 3,
            y: 3,
            width: contentView.height-6,
            height: contentView.height-6)
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.height/2.0
        
        let buttonWidth =  contentView.width > 500 ? 220.0 : contentView.width/3
        followButton.frame = CGRect(
            x: contentView.width-5-buttonWidth,
            y: (contentView.height-40)/2,
            width: buttonWidth,
            height: 40)
        
        let labelHeight = contentView.height/2
        nameLabel.frame = CGRect(
            x: profilePhotoImageView.right+5,
            y: 0,
            width: contentView.width-8-profilePhotoImageView.width-buttonWidth,
            height: labelHeight)
        
        usernameLabel.frame = CGRect(
            x: profilePhotoImageView.right+5,
            y: nameLabel.bottom,
            width: contentView.width-8-profilePhotoImageView.width-buttonWidth,
            height: labelHeight)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profilePhotoImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    //MARK:- Actions for buttons
    @objc private func didTapFollowButton(){
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    //MARK:- Public functions
    public func configure(with model: UserRelationship){
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        switch model.type {
        case .following:
            // show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
            followButton.setTitleColor(.label, for: .normal)
        
        case .not_following:
            followButton.setTitle("Follow", for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
            followButton.setTitleColor(.white, for: .normal)
        
        }
    }
}
