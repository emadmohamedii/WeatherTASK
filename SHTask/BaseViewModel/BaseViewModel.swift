//
//  BaseViewModel.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//

import Foundation
import RxSwift
import RxCocoa


class BaseViewModel {
    
    // Dispose Bag
    let disposeBag = DisposeBag()
//    let alert = PublishSubject<(String, Theme)>()
    let alertDialog = PublishSubject<(String,String)>()
    
}
