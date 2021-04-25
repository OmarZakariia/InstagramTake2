//
//  IGFeedPostTableViewCell.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /254/21.
//

import UIKit

/// I will use this class to know how to show each of the cells
class IGFeedPostTableViewCell: UITableViewCell {

    // Static identifier so I can be able to use the cell
    static let identifier = "IGFeedPostTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Public functions
    public func configure(){
        //Configure the cells 
    }
}
