
import UIKit

public class CActivityIndicator{
    
    let ActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    var view : UIView?
    var overlayView = UIView()
    
    let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    
    public init(){
        
        self.view = keyWindow//UIApplication.shared.keyWindow
        self.addOverLay()
        self.addActivityIndicator()
    }
    private func addActivityIndicator(){
        if let view = self.view {
            ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            ActivityIndicator.center = view.center
            view.addSubview(ActivityIndicator)
        }
    }
    private func addOverLay(){
        guard let view = self.view else { return }
        overlayView.frame = CGRect(x: 0, y: 0, width: (view.frame.width), height: view.frame.height)
        overlayView.center = view.center
        overlayView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        overlayView.isHidden = true
        view.addSubview(overlayView)
        
    }
    private func showOverLay(){
        self.overlayView.isHidden = false
    }
    private func HideOverLay(){
        self.overlayView.isHidden = true
    }
    public func start(){
        ActivityIndicator.startAnimating()
        self.showOverLay()
    }
    public func stop(){
        ActivityIndicator.stopAnimating()
        self.HideOverLay()
    }
}
