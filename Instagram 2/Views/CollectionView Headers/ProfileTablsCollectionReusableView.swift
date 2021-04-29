//
//  ProfileTablsCollectionReusableView.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /274/21.
//

import UIKit

class ProfileTablsCollectionReusableView: UICollectionReusableView {
        static let identifier = "ProfileTablsCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
