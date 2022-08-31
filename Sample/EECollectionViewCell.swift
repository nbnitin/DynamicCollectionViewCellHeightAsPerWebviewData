//
//  EECollectionViewCell.swift
//  Sample
//
//  Created by Nitin Bhatia on 04/08/22.
//

import UIKit
import WebKit

protocol webCell {
    func didButtonPressed()
}

class EECollectionViewCell: UICollectionViewCell,WKNavigationDelegate  {
   
    @IBOutlet weak var btnClick: UIButton!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var containerView: UIView!
    
    var heightNew: CGFloat = 0
    var didButtonPressed : Bool = false
    var delegate : webCell?
    
    @IBAction func btnAction(_ sender: Any) {
        if height.constant > 0 {
            height.constant = 0
            btnClick.setTitle("Show", for: .normal)
        } else {
            height.constant = heightNew
            btnClick.setTitle("Hide", for: .normal)
        }
        delegate?.didButtonPressed()
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func setupLabel() {
        webView.navigationDelegate = self

        let html = """
                <html>
    
                   <head>
<script>
            var meta = document.createElement('meta');
            meta.setAttribute('name', 'viewport');
            meta.setAttribute('content', 'width=device-width - 40');
            meta.setAttribute('initial-scale', '0.5');
            meta.setAttribute('maximum-scale', '1.0');
            meta.setAttribute('minimum-scale', '0.5');
            meta.setAttribute('user-scalable', 'no');
            document.getElementsByTagName('head')[0].appendChild(meta);
</script>
                    </head>

                <body style="margin:0">
                    <div style='margin:0 auto; width: 335; height:171;margin-bottom:28'>
                        <iframe width="100%" height="100%" src="https://www.youtube.com/embed/DgL4RgLtSKU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                    </div>
                    <div>
                        <b>Lorem Ipsum</b> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    </div>

                    <div>
                        <b>Lorem Ipsum</b> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    </div>

                    <div>
                        <b>Lorem Ipsum</b> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. End
                    </div>
            
                </body>


"""
        
        webView.loadHTMLString(html, baseURL: nil)
        webView.scrollView.isScrollEnabled = false
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
            
                self.heightNew = height as! CGFloat
          
           
            })
    }
    
   


}
