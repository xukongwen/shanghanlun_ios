
import UIKit

class DrageandDropView: UIViewController {
    
//    @IBOutlet weak var fileImageView: UIImageView!
//    @IBOutlet weak var trashImageView: UIImageView!
    
    
    
    @IBOutlet weak var transhImageView: UIImageView!
    
    @IBOutlet weak var fileImageView: UIImageView!
    
    var fileViewOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPanGesture(view: fileImageView)
        fileViewOrigin = fileImageView.frame.origin
        view.bringSubviewToFront(fileImageView)
    }
    
    func addPanGesture(view: UIView) {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(DrageandDropView.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    // Refactor
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        let fileView = sender.view!
        
        switch sender.state {
            
        case .began, .changed:
            moveViewWithPan(view: fileView, sender: sender)
            
        case .ended:
            if fileView.frame.intersects(transhImageView.frame) {
                //deleteView(view: fileView)
                returnViewToOrigin(view: fileView)
                
            } else {
                //returnViewToOrigin(view: fileView)
                deleteView(view: fileView)
            }
            
        default:
            break
        }
    }
    
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    
    func returnViewToOrigin(view: UIView) {
        
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.fileViewOrigin
        })
    }
    
    
    func deleteView(view: UIView) {
        
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
        })
    }
}


