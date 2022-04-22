import UIKit


protocol CustomSegmentDelegate {
    func chooseSegment(_ isFirstSelected: Bool)
}

//@IBDesignable
class CustomSegmentControl: UIView {
    
    @IBInspectable var firstSegmentTitle = "First"
    @IBInspectable var secondSegmentTitle = "Second"
    @IBInspectable var controllerBackgroundColor: UIColor = .lightGray
    @IBInspectable var activeSegmentColor: UIColor = .gray
    
    
    let firstSegment = UIButton()
    let secondSegment = UIButton()
    let segmentStack = UIStackView()
    
    var isFirst: Bool = true
    var delegate: CustomSegmentDelegate?

    
    override func layoutSubviews() {
        
    // first segment
        firstSegment.backgroundColor = activeSegmentColor
        firstSegment.layer.cornerRadius = 24
        firstSegment.setTitle(firstSegmentTitle, for: .normal)
        firstSegment.titleLabel?.textColor = .white
        
    // second segment
        secondSegment.backgroundColor = .clear
        secondSegment.layer.cornerRadius = 24
        secondSegment.setTitle(secondSegmentTitle, for: .normal)
        secondSegment.titleLabel?.textColor = .white
        
    // segment stack
        segmentStack.translatesAutoresizingMaskIntoConstraints = false
        segmentStack.backgroundColor = controllerBackgroundColor
        segmentStack.layer.cornerRadius = 24
        segmentStack.distribution = .fillEqually
        segmentStack.addArrangedSubview(firstSegment)
        segmentStack.addArrangedSubview(secondSegment)
        addSubview(segmentStack)
        
        NSLayoutConstraint.activate([
            segmentStack.topAnchor.constraint(equalTo: self.topAnchor),
            segmentStack.leftAnchor.constraint(equalTo: self.leftAnchor),
            segmentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            segmentStack.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
// Actions
    
    func setUpActions() {
        firstSegment.addTarget(self, action: #selector(chooseFirst), for: .touchUpInside)
        secondSegment.addTarget(self, action: #selector(chooseSecond), for: .touchUpInside)
    }
    
    @objc private func chooseFirst() {
        if !isFirst {
            isFirst = true
            firstSegment.backgroundColor = activeSegmentColor
            secondSegment.backgroundColor = .clear
            delegate?.chooseSegment(isFirst)
        }
    }
    
    @objc private func chooseSecond() {
        if isFirst {
            isFirst = false
            firstSegment.backgroundColor = .clear
            secondSegment.backgroundColor = activeSegmentColor
            delegate?.chooseSegment(isFirst)
        }
    }
}
