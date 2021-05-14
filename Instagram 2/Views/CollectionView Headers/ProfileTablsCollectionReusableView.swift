//
//  ProfileTablsCollectionReusableView.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /274/21.
//

import UIKit

protocol ProfileTablsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButtonTab()
}

class ProfileTablsCollectionReusableView: UICollectionReusableView {
    
    //MARK:- Constants and Variables
    static let identifier = "ProfileTablsCollectionReusableView"
    public weak var delegate: ProfileTablsCollectionReusableViewDelegate?
    
    //MARK:- Structs
    struct Constants {
        static let padding: CGFloat = 8
    }
    
    //MARK:- Subviews
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
        
    }()
    
    //MARK:- Initializers and overriden methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(gridButton)
        addSubview(taggedButton)
        
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = height - (Constants.padding * 2)
        let gridButtonX = ((width/2)-size)/2
        
        gridButton.frame = CGRect(
            x: gridButtonX,
            y: Constants.padding,
            width: size,
            height: size)
        
        taggedButton.frame = CGRect(
            x: gridButtonX + (width/2),
            y: Constants.padding,
            width: size,
            height: size)
    }
    
    //MARK:- Actions for buttons
    @objc private func didTapGridButton(){
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    
    @objc private func didTapTaggedButton(){
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        delegate?.didTapTaggedButtonTab()
    }
}
