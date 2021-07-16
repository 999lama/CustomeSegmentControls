//
//  SegmentControlWithRect.swift
//  CustomizSegmentsControl
//
//  Created by Lama Albadri on 16/07/2021.
//

import UIKit
@IBDesignable
class SegmentContolWithSquare: UIControl {
    var selectedSegmentIndex = 0
    var buttons = [UIButton]()
    var selector : UIView!
    // to make this property see in attribuites inspector
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor : UIColor = UIColor.clear {
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }

    
    
    @IBInspectable
    var commaSeparatedButtonTitles : String = ""{
        didSet{
            updateView()
        }
    }
    
    
    @IBInspectable
    var textColor : UIColor = .black {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor : UIColor  = #colorLiteral(red: 0.3803684115, green: 0.38041085, blue: 0.8809766173, alpha: 1)  {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectoTextColor : UIColor = .white {
        didSet{
            updateView()
        }
    }
    func updateView(){
        // a need to clear out each time this array
        buttons.removeAll()
        subviews.forEach{ $0.removeFromSuperview()}
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        for buttonTitle in buttonTitles{
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)

            buttons.append(button)
        }
        buttons[0].setTitleColor(textColor, for: .normal)
      
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        // start of from up and left cornoer x = 0 , y = 0
        selector = UIView(frame: CGRect(x: 0 , y: 0, width: selectorWidth , height: frame.height))
        selector.layer.cornerRadius = 10
        selector.clipsToBounds = true
        selector.backgroundColor = selectorColor
        addSubview(selector)
        // add this array of buttons and add it to the view - we will add them to UIStackView
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill // the button will take all the space of stackView
        sv.distribution = .fillProportionally
        sv.backgroundColor = .clear
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        sv.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        

    }
    
    override func draw(_ rect: CGRect) {
        // draeing code - in storyboard or in the application run
        
        layer.cornerRadius = 10
    }
    
    @objc
    func buttonTapped(button: UIButton){
        for ( buttonIndex ,btn) in buttons.enumerated(){
            btn.setTitleColor(textColor, for: .normal)
            if btn == button{
                selectedSegmentIndex = buttonIndex
                let selectorStartPoistion = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selector.frame.origin.x  = selectorStartPoistion
                }
                btn.setTitleColor(selectoTextColor, for: .normal)
            }
            sendActions(for: .valueChanged)
    }
    
    
}
 
}

