//
//  LoginViewController.swift
//  App
//
//  Created by laijihua on 4/2/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAuthHtml()
    }
    
    func loadAuthHtml(){
        let url = Constans.authHtmlUrl
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension LoginViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        debugLog("will load view")
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.URLString
        if url.hasPrefix(Constans.authRetUrl) {
            print("😊😊😊😊😊😊" + url)
            Github().handleOpenURL(request.URL!, configuration: Constans.authConfig, completion: { (config) in
                if let con = config {
                    self.loadCurrentUser(con)
                }
            })
            return false
        }
        return true
    }
    
    func loadCurrentUser(config: TokenConfiguration) {
        
        // 保存accessToken
        Constans.save(config.accessToken, key: .AccessToken)
        Github(config).me { (response) in
            print(response.login)
        }
        navigationController?.popViewControllerAnimated(true)
        
    }

    
    
    
}
