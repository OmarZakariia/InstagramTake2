//
//  LikeEventTableViewCell.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /165/21.
//

import UIKit

//MARK:- Protocol
protocol LikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: String)
}


class LikeEventTableViewCell: UITableViewCell {

        //MARK:- Variables and Constants
      static let identifier = "LikeEventTableViewCell"
        
        weak var delegate: LikeEventTableViewCellDelegate?
        
        //MARK:- Subviews
        private let profileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFill
            
            return imageView
        }()
        
        private let label: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.numberOfLines = 0
            
            return label
        }()
        
        private let postButton : UIButton = {
            let button = UIButton()
            
            return button
        }()
        
        //MARK:- Initializers and Overriden methods
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.clipsToBounds = true
            contentView.addSubview(profileImageView)
            contentView.addSubview(label)
            contentView.addSubview(postButton)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            postButton.setBackgroundImage(nil, for: .normal)
            label.text = nil
            profileImageView.image = nil
            
        }
        
        //MARK:- Public Functions
        public func configure(with model: String){
            
        }
    }

