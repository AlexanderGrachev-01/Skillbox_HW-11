import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customButton: CustomButton!
    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var customSegmentController: CustomSegmentControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSegmentController.setUpActions()
        customSegmentController.delegate = self
    }
}

extension ViewController: CustomSegmentDelegate {
    func chooseSegment(_ isFirstSelected: Bool) {
        if isFirstSelected {
            print("first")
        } else {
            print("second")
        }
    }
}

