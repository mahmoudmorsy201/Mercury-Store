//
//  ShoppingCartViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//
import Foundation
import RxSwift
import RxCocoa

struct Input {
    let value: Observable<(id: UUID, value: Int)>
    let delete: Observable<UUID>
    let add: Observable<Void>
}

struct ViewModel {
    var counters: Driver<[ShoppingCartItem]>
}

extension ViewModel {
    private enum Action {
        case add(model: [ShoppingCartItem])
        case value(id: UUID, value: Int)
        case delete(id: UUID)
    }
    
    init(_ input: Input, refreshTask: @escaping () -> Observable<[ShoppingCartItem]>) {
        let addAction = input.add
            .flatMapLatest(refreshTask)
            .map(Action.add)
        let valueAction = input.value.map(Action.value)
       
        let deleteAction = input.delete.map(Action.delete)
        
        counters = Observable.merge(addAction,valueAction, deleteAction)
            .scan(into: []) { model, new in
                switch new {
                case .add(let values):
                    model = values
                case .value(let id, let value):
                    if let index = model.firstIndex(where: { $0.id == id }) {
                        model[index].quantity = value
                    }
                case .delete(let id):
                    if let index = model.firstIndex(where: { $0.id == id }) {
                        model.remove(at: index)
                    }
                }
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}




