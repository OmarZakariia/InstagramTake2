//
//  ProfileInfoHeaderReusableView.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /274/21.
//

import UIKit

class ProfileInfoHeaderReusableView: UICollectionReusableView {
        static let identifier = "ProfileInfoHeaderReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
