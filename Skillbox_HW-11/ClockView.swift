import UIKit

//@IBDesignable
class ClockView: UIView {


    @IBInspectable var hourArrowLenth:CGFloat = 10
    @IBInspectable var hourArrowWidth: CGFloat = 10
    @IBInspectable var hourArrowColour: UIColor = .white
    
    @IBInspectable var minArrowLenth:CGFloat = 15
    @IBInspectable var minArrowWidth: CGFloat = 5
    @IBInspectable var minArrowColour: UIColor = .white
    
    @IBInspectable var secArrowLenth:CGFloat = 20
    @IBInspectable var secArrowWidth: CGFloat = 2
    @IBInspectable var secArrowColour: UIColor = .white

    let innerView = UIView()
    let hourArrowView = UIView()
    let minuteArrowView = UIView()
    let secondArrowView = UIView()
    
    var timer: Timer?
    
    
    override func layoutSubviews() {
        
    //inner View (for edge)
       
        innerView.frame.size = CGSize(width: frame.size.width, height: frame.size.height)
        innerView.layer.cornerRadius = frame.size.width / 2.0 - 30.0
        innerView.backgroundColor = .black
        addSubview(innerView)
   
    //markers arrangement
        for hr in (1...12){
        let marker = UIView()
        let markerTip = UIView()
        var dim: CGFloat //minimum dimention of inner view
            if innerView.frame.size.width <= innerView.frame.size.height{
                dim = innerView.frame.size.width
            } else {dim = innerView.frame.height}

        marker.frame = CGRect(x: dim / 2.0 - dim / 80, y: 0.0, width: dim / 40, height: dim / 2.0)
        marker.center = innerView.center
        marker.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
            
            var h: Int //tip height
                if (hr % 3) == 0 {
                    h = Int(marker.frame.size.height / 5)
                }else {h = Int(marker.frame.size.height / 8)}
        markerTip.backgroundColor = .white
        markerTip.frame = CGRect(x: 0, y: 0, width: Int(marker.frame.size.width), height: h)
        marker.addSubview(markerTip)
        
            let angel = CGFloat(Float(hr % 12) * 2.0 / 12.0) * CGFloat.pi
            marker.transform = CGAffineTransform(rotationAngle: angel)
            
            innerView.addSubview(marker)
        }
        
//Arrows
        //form arrows
        innerView.addSubview(makeArrow(arrow: hourArrowView, height: hourArrowLenth, width: hourArrowWidth, colour: hourArrowColour))
        innerView.addSubview(makeArrow(arrow: minuteArrowView, height: minArrowLenth, width: minArrowWidth, colour: minArrowColour))
       innerView.addSubview(makeArrow(arrow: secondArrowView, height: secArrowLenth, width: secArrowWidth, colour: secArrowColour))
        
        //rotate arrows
        rotateAllArows()
     
        //update arrow every second
        createTimer()
        
        //Center
        innerView.addSubview(formCenter())

    
    }


    func makeArrow (arrow : UIView, height: CGFloat, width: CGFloat, colour: UIColor) -> UIView{
        arrow.frame = CGRect(x: innerView.frame.size.width / 2 - width / 2, y: innerView.frame.size.height / 2 - height, width: width, height: height)
        arrow.center = innerView.center
        arrow.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        arrow.backgroundColor = colour
        return arrow
    }
    
    func rotateArrow(arrow : UIView, angel: CGFloat){
        arrow.transform = CGAffineTransform(rotationAngle: angel)
    }
    
    @objc func rotateAllArows() {
        rotateArrow(arrow: hourArrowView, angel: timeToAngel(hr0_min1_sec2: 0))
        rotateArrow(arrow: minuteArrowView, angel: timeToAngel(hr0_min1_sec2: 1))
        rotateArrow(arrow: secondArrowView, angel: timeToAngel(hr0_min1_sec2: 2))
    }
    
    func createTimer(){
        if timer == nil{
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(rotateAllArows), userInfo: nil, repeats: true)
        }
    }
    
    func formCenter() -> UIView{
        let r = UIView()
        r.frame.size = CGSize(width: 15, height: 15)
        r.center = innerView.center
        r.backgroundColor = .white
        r.layer.cornerRadius = 7.5
        return r
    }

    
    func timeToAngel(hr0_min1_sec2 hms: Int) -> CGFloat{
        // Transformation Date to hour, minutes or secunds, depending of input choosen
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        //0 - out Houre, 1 - out min 2 - out sec
        switch hms {
        case 0: return ((CGFloat(hour % 12) + CGFloat(minute) / 60.0)) / 12 * 2 * CGFloat.pi
        case 1: return (CGFloat(minute) + CGFloat(second) / 60) / 60 * 2 * CGFloat.pi
        case 2: return CGFloat(second) / 60 * 2 * CGFloat.pi
        default: return 0.0
        }
    }
    

    
}
