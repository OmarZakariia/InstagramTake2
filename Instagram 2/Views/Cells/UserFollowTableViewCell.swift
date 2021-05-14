//
//  UserFollowTableViewCell.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /145/21.
//

import UIKit

protocol nameUserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model : String)
}

class UserFollowTableViewCell: UITableViewCell {

    //MARK:- Variables and Constants
    static let identifier = "UserFollowTableViewCell"
    
    public weak var delegate: nameUserFollowTableViewCellDelegate?
    
    //MARK:- Subviews
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        
        
        return label
    }()
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    private let followButton : UIButton = {
        let button = UIButton()
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
    
    //MARK:- Public functions
    public func configure(with model: String){
        
    }
}
