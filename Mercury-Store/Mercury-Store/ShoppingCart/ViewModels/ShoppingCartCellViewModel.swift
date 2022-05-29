//
//  ShoppingCartCellViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 30/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

struct ShoppingCartCellInput {
    let increaseBtn: Observable<Void>
    let decreaseBtn: Observable<Void>
    let deleteBtnObservable: Observable<Void>
}

struct ShoppingCartCellViewModel {
    let quantityLabelObservable: Observable<String>
    let quantityObservable: Observable<Int>
    let delete: Observable<Void>
    let plusBtnObservable: Observable<Bool>
    let minusBtnObservable: Observable<Bool>
    private let enablePlusBtnSubject = BehaviorRelay<Bool>(value: true)
    private let enableMinusBtnSubject = BehaviorRelay<Bool>(value: true)
}

extension ShoppingCartCellViewModel {
    init(_ input: ShoppingCartCellInput, initialValue: ShoppingCartItem) {
        let add = input.increaseBtn.map { 1 }// plus adds one to the value
        let subtract = input.decreaseBtn.map { -1 }// minus subtracts one
        
        quantityObservable = Observable.merge(add,subtract)
            .scan(initialValue.quantity, accumulator: +)
            
        
        plusBtnObservable = enablePlusBtnSubject.asObservable()
        
        minusBtnObservable = enableMinusBtnSubject.asObservable()
        
        if (initialValue.quantity >= 10) {
            enablePlusBtnSubject.accept(false)
        }
        
        if (initialValue.quantity <= 1) {
            enableMinusBtnSubject.accept(false)
        }
            
        
        quantityLabelObservable = quantityObservable
            .map {"\($0)"}
        
        delete = input.deleteBtnObservable
    }
}

