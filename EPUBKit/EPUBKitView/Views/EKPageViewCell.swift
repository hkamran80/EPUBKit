//
//  EKViewCell.swift
//  EPUBKit
//
//  Created by Witek on 06/08/2017.
//  Copyright © 2017 Witek Bobrowski. All rights reserved.
//

import UIKit
import WebKit

class EKPageViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var pageView: UIView!
    fileprivate var webView: WKWebView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
}


extension EKPageViewCell {

    func configure(with file: String, id: Int, at path: URL) {
        titleLabel.text = file
        pageLabel.text = String(id + 1)
        webView.loadFileURL(path, allowingReadAccessTo: path.deletingLastPathComponent())
    }

//TODO: Populating cell with page content
//
//    func configure(with page: Page) {
//        webView.loadHTMLString(page.HTMLContent, baseURL: page.baseURL)
//    }
    
    fileprivate func configure() {
        webView = WKWebView(frame: pageView.frame)
        pageView.addSubview(webView)
        constrainView(view: webView, toView: pageView)
    }
    
    fileprivate func constrainView(view:UIView, toView contentView:UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}