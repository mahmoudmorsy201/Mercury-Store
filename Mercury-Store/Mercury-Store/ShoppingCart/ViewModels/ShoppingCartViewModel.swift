//
//  ShoppingCartViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//
import Foundation
import RxSwift
import RxCocoa

struct ShoppingCartInput {
    let increaseAndDecreaseQuantity: Observable<(id: UUID, value: Int)>
    let deleteInput: Observable<UUID>
    let getNewData: Observable<Void>
}

struct ShoppingCartViewModel {
    var dataFromDB: Driver<[ShoppingCartItem]>
}

extension ShoppingCartViewModel {
    private enum ShoppingCartAction {
        case newDataSync(model: [ShoppingCartItem])
        case quantityChangeInModel(id: UUID, value: Int)
        case deleteDataFromModels(id: UUID)
    }
    
    init(_ input: ShoppingCartInput, refreshTask: @escaping () -> Observable<[ShoppingCartItem]>) {
        let addAction = input.getNewData
            .flatMapLatest(refreshTask)
            .map(ShoppingCartAction.newDataSync)
        let valueAction = input.increaseAndDecreaseQuantity.map(ShoppingCartAction.quantityChangeInModel)
       
        let deleteAction = input.deleteInput.map(ShoppingCartAction.deleteDataFromModels)
        
        dataFromDB = Observable.merge(addAction,valueAction, deleteAction)
            .scan(into: []) { model, new in
                switch new {
                case .newDataSync(let values):
                    model = values
                case .quantityChangeInModel(let id, let value):
                    if let index = model.firstIndex(where: { $0.id == id }) {
                        model[index].quantity = value
                    }
                case .deleteDataFromModels(let id):
                    if let index = model.firstIndex(where: { $0.id == id }) {
                        model.remove(at: index)
                    }
                }
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}




