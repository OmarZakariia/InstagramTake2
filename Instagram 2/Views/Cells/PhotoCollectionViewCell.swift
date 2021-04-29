//
//  PhotoCollectionViewCell.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /274/21.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Variables and Constants
    static let identifier = "PhotoCollectionViewCell"
    
    // ImageView
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // assign frames
        photoImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        // The next 2 lines are for the visually impaired and uses voice over when the user taps sth audio should say the next line
        accessibilityLabel = "User Post Label"
        accessibilityHint = "Double-Tap to open post" // this is the text that is said out loud
        
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Public Functions
    public func configure(with model: UserPost){
        // get URL
        let url = model.thumbnailImage
        // now I want to download the asset from the URL and assign it to the image view
        photoImageView.sd_setImage(with: url , completed: nil)
    }
    
    public func configure(debug imageName: String){
        // this function is for testing
        photoImageView.image = UIImage(named: imageName)
    }
}
