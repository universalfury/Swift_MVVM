//
//  ErrorView.swift
//  MVVMProject
//
//  Created by Vartika on 22/01/21.
//

import UIKit

protocol ErrorViewDelegate: class {
    func tryAgainCallBack()
}

class ErrorView: UIView {
    
    @IBOutlet weak var apiErrorView: UIView!
    weak var delegate: ErrorViewDelegate?
    
    @IBAction func retryAPIHit(_ sender: Any) {
        delegate?.tryAgainCallBack()
    }
    
}
