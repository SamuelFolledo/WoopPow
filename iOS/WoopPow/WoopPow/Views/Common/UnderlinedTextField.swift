//
//  UnderlinedTextField.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

//  inspired by Stackoverflow's post https://stackoverflow.com/questions/31107994/how-to-only-show-bottom-border-of-uitextfield-in-swift/31108018

import UIKit

///UITextField as just line with no borders. Can change the line color
class UnderlinedTextField: UITextField {
    //views
    private let defaultUnderlineColor = UIColor.label
    private let bottomLine = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    required init() { //with initializer
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        borderStyle = .none
        contentVerticalAlignment = .center //added
        clearButtonMode = .unlessEditing //added
        tintColor = defaultUnderlineColor
        font = FontManager.setFont(size: 18, fontType: .medium)
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.backgroundColor = defaultUnderlineColor
        self.addSubview(bottomLine)
        bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true //updated to make the line closer to the text
        bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
    }
    
    //Setters
    public func setUnderlineColor(color: UIColor = .red) {
        bottomLine.backgroundColor = color
    }
    
    public func setDefaultUnderlineColor() {
        bottomLine.backgroundColor = defaultUnderlineColor
    }
    
    //Helpers
    public func hasError() {
        self.setUnderlineColor(color: .systemRed)
    }
    
    public func hasNoError() {
        self.setDefaultUnderlineColor()
    }
}
