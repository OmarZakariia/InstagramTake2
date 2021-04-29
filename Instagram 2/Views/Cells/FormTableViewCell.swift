//
//  FormTableViewCell.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /274/21.
//

import UIKit
protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel)
    
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    //MARK:- Variables and Constants
    static let identifier = "FormTableViewCell"
    public weak var delegate: FormTableViewCellDelegate?
    // weak var so I dont cause memory leak
    
    private var model: EditProfileFormModel?
    
    //MARK:- Subviews for the cell
    private let formLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        selectionStyle = .none
        field.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // assign frames
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.width/3, height: contentView.height)
        
        field.frame = CGRect(x: formLabel.right + 5, y: 0, width: contentView.width - 10 - formLabel.width, height: contentView.height)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // I'm making sure that the value will never be used for the next one
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
        
    }
    
    //MARK:- Public functions
    public func configure(with model: EditProfileFormModel){
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    //MARK:- UITextFieldDelegate Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        model?.value = textField.text // get the latest text field value
        
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell(self, didUpdateField: model)
        // everytime the user presses the return key on the field we're editing, call that function
        textField.resignFirstResponder()
        return true
    }
}

