//
//  BaseViewController.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//

import UIKit
import RxSwift
import RxCocoa


class BaseViewController: UIViewController, ActivityIndicatorViewable {
    
    let disposeBag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

