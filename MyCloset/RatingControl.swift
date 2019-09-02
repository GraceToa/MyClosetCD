//
//  RatingControl.swift
//  MyCloset
//
//  Ref: developer.apple.com / Implementing a Custom Control
//  Created by GraceToa on 31/07/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

 @IBDesignable class RatingControl: UIStackView {
    
    @IBInspectable var starSize: CGSize = CGSize(width: 40.0, height: 40.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    // MARK: - Iniatialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
   
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    
    // MARK: - Private Methods

    private func setupButtons()  {
        
        //clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Load Button Images
        let bundle = Bundle(for: type(of: self))
        let starD = UIImage(named: "starD", in: bundle, compatibleWith: self.traitCollection)
        let starYellow = UIImage(named: "starYellow", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)

        
        for _ in 0..<starCount {
            
            let button = UIButton()
            
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(starYellow, for: .selected)
            button.setImage(starD, for: .highlighted)
            button.setImage(starD, for: [.highlighted, .selected])
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //Add the button to the stack
            addArrangedSubview(button)
            
            //Add the new button to the rating button array
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    // MARK: - Button Action
    
    @objc func ratingButtonTapped(button: UIButton){
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array")
        }
        //Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        }else {
            rating = selectedRating
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button ) in ratingButtons.enumerated() {
            //If the index of a button is less than the rating, that button should be selected
            button.isSelected = index < rating
        }
    }
}
