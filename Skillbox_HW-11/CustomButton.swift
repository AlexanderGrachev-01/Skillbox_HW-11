import UIKit


// @IBDesignable
class CustomButton: UIButton {
    
    var isSetupted = false
    
    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    @IBInspectable var bordeColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor }
        get { return layer.borderColor?.UIColor }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isSetupted { return }
        isSetupted = true
    }
}

extension CGColor {
    fileprivate var UIColor: UIKit.UIColor {
        return UIKit.UIColor(cgColor: self)
    }
}
