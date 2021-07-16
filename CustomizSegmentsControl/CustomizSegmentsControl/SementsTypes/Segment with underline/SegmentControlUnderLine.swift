//
//  SegmentControlUnderLine.swift
//  CustomizSegmentsControl
//
//  Created by Lama Albadri on 16/07/2021.
//


import UIKit
@IBDesignable

class CustomeSegmentControllWithUnderLine: UIControl {

    var selectedSegmentIndex = 0
    var selector : UIView!
    var buttons = [UIButton]()
    
    
    //MARK: Segment Boarder width
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    //MARK: Segment Boarder Color
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
    
    
    //MARK: a segment controls elemnts textColor
    @IBInspectable
    var textColor : UIColor = .black {
        didSet{
            updateView()
        }
    }
    
    //MARK: a deafult Value for selected Text and backGround you can change it with storyBoard Inspector
    @IBInspectable
    var selectorColor : UIColor  = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)  {
        didSet{
            updateView()
        }
    }
    @IBInspectable
    var selectoTextColor : UIColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1) {
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        // a need to clear out each time this array
        buttons.removeAll() // remove the buttons
        subviews.forEach{ $0.removeFromSuperview()} // remove the selected views
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        for buttonTitle in buttonTitles{
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)

            buttons.append(button)
        }
        
        buttons[0].setTitleColor(textColor, for: .normal)
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        selector = UIView(frame: CGRect(x: 0 , y: frame.height , width: selectorWidth - 10 , height: 5 ))
        self.backgroundColor = .clear
        selector.backgroundColor = selectorColor
        addSubview(selector)
        // add this array of buttons and add it to the view - we will add them to UIStackView
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill // the button will take all the space of stackView
        sv.distribution = .fillProportionally
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        sv.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    //MARK:  drawing code - in storyboard or in the application run
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
    }
    
    //MARK: button Tapped func
   @objc func buttonTapped(button : UIButton){
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
