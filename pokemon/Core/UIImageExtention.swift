
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImageWithUrlString(urlStr:String) {
        let url = URL(string: urlStr.vaildStringUrl() ?? "")
        self.kf.setImage(with: url)
    }
    func setImageWithUrlString_load(urlStr:String,callback:@escaping ()->Void) {
        let url = URL(string: urlStr.vaildStringUrl() ?? "")
        self.kf.setImage(with: url) {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                callback()
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }

    func setImageWithUrlString(urlStr: String,placholder: UIImage? = nil) {
        let url = URL(string: urlStr.vaildStringUrl() ?? "")
        self.kf.setImage(with: url, placeholder: placholder, options: nil, progressBlock: nil) { (nil) in
            
            }
        }
    
    func cornerRadius() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }

    func changeImage(for image: String, orientation: UIImage.Orientation) {
        if let stringImg = UIImage(named: image), let cgImage = stringImg.cgImage {
            let resultImage = UIImage(cgImage: cgImage, scale: stringImg.scale, orientation: orientation)
            self.image = resultImage
        }
    }
}

extension UIImage{
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

extension String{
    func vaildStringUrl() -> String? {
        guard let url = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Invailed String URL")
            return nil
        }
        return url.replacingOccurrences(of: " ", with: "%20")
    }
}
