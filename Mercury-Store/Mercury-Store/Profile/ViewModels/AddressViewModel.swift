//
//  AddressViewModel.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 13/06/2022.
//

import RxSwift
import RxCocoa

protocol AddressViewModelType {
    
    var countryObservable: AnyObserver<String?> { get }
    var cityObservable: AnyObserver<String?> { get }
    var addressObservable: AnyObserver<String?> { get }
    var phoneObservable: AnyObserver<String?> { get }
    var isValidForm: Observable<Bool> { get }
    func postAddress(_ address:AddressRequestItem)
    func getUserFromUserDefaults() -> User?
   // var addressCheckErrorMessage: Observable<String?> { get }
    //var showErrorLabelObserver: Observable<Bool> { get }
   
}
class AddressViewModel: AddressViewModelType {
    private let countrySubject = BehaviorSubject<String?>(value: "")
    private let citySubject = BehaviorSubject<String?>(value: "")
    private let addressSubject = BehaviorSubject<String?>(value: "")
    private let phoneSubject = BehaviorSubject<String?>(value: "")
    private let disposeBag = DisposeBag()
    
    private let addressProvider: AddressProvider
    private let addressRequestPost:PublishSubject<AddressResponse> = PublishSubject<AddressResponse>()
    private let addressRequestPostError = PublishSubject<Error>()
   // private let showErrorMessage = PublishSubject<String?>()
   // private let showErrorLabelSubject = BehaviorSubject<Bool>(value: true)
    
    var countryObservable: AnyObserver<String?> { countrySubject.asObserver() }
    
    var cityObservable: AnyObserver<String?> { citySubject.asObserver() }
    
    var addressObservable: AnyObserver<String?> { addressSubject.asObserver() }
    
    var phoneObservable: AnyObserver<String?> { phoneSubject.asObserver() }
    
    
  //  var addressCheckErrorMessage: Observable<String?> { showErrorMessage.asObservable() }
    
  //  var showErrorLabelObserver: Observable<Bool> { showErrorLabelSubject.asObservable() }
    
    var isValidForm: Observable<Bool> {
        return Observable.combineLatest( countrySubject, citySubject,addressSubject, phoneSubject) { country, city, address, phone in
            guard country != nil && city != nil && address != nil && phone != nil  else {
                return false
            }
            return !(country!.isEmpty) &&  !(city!.isEmpty) && phone!.isValidPhone() && !(address!.isEmpty)
        }
    }
    init(_ addressProvider: AddressProvider = AddressClient()) {
        self.addressProvider = addressProvider
    }
    
    func postAddress( _ address:AddressRequestItem){
        let user = getUserFromUserDefaults()
        addressProvider.postAddress(with: user!.id, addressRequest: AddressRequest(address: address))
        .subscribe(onNext: { [weak self] result in
            guard let `self` = self else {fatalError()}
            self.addressRequestPost.onNext(result)
        }, onError: { [weak self] error in
            guard let `self` = self else {fatalError()}
            self.addressRequestPostError.onNext(error)
        })
        .disposed(by: disposeBag)
    }
    func getUserFromUserDefaults() -> User? {
            do {
                return try UserDefaults.standard.getObject(forKey: "user", castTo: User.self)
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
}
