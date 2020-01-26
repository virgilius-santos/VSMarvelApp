
import UIKit
import SnapKit

extension UIView {
    
    private var backGrounViewTag: Int { return 3432 }
    
    func lock() {
        if viewWithTag(backGrounViewTag) != nil {
            return
        }
        
        let backGrounView = UIView()
        backGrounView.tag = backGrounViewTag
        backGrounView.alpha = 0
        backGrounView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        
        addSubview(backGrounView)
        backGrounView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        
        backGrounView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.snp.makeConstraints {
            $0.center.equalTo(backGrounView)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            backGrounView.alpha = 1
        }) { (_) in
            activityIndicator.startAnimating()
        }
        
    }
    
    func unlock() {
        guard let backGroundView = self.viewWithTag(backGrounViewTag) else {
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            backGroundView.alpha = 0
        }) { (_) in
            backGroundView.removeFromSuperview()
        }
    }
}
