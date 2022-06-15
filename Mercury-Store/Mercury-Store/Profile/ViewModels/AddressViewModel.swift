//
//  AddressViewModel.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 13/06/2022.
//
import Foundation
import RxSwift
import RxCocoa

protocol AddressViewModelType {
    
    var countryObservable: AnyObserver<String?> { get }
    var cityObservable: AnyObserver<String?> { get }
    var addressObservable: AnyObserver<String?> { get }
    var phoneObservable: AnyObserver<String?> { get }
    var isValidForm: Observable<Bool> { get }
    var addresses: Driver<[CustomerAddress]> {get}
    func postAddress(_ address:AddressRequestItem)
    func getAddress()
    func getUserFromUserDefaults() -> User?
    func updateAddress(_ address:AddressRequestItemPut)
    func goToEditAddressScreen(with address: CustomerAddress)
}
class AddressViewModel: AddressViewModelType {
    
    private let countrySubject = BehaviorSubject<String?>(value: "")
    private let citySubject = BehaviorSubject<String?>(value: "")
    private let addressSubject = BehaviorSubject<String?>(value: "")
    private let phoneSubject = BehaviorSubject<String?>(value: "")
    private let disposeBag = DisposeBag()
    var addresses: Driver<[CustomerAddress]>
    private let addressProvider: AddressProvider
    private let addressRequestPost:PublishSubject<AddressResponse> = PublishSubject<AddressResponse>()
    private let addressRequestGett:PublishSubject = PublishSubject<[CustomerAddress]>()
    private let addressRequestPostError = PublishSubject<Error>()
    private weak var addressNavigationFlow : UpdateAddressNavigationFlow?
    
    var countryObservable: AnyObserver<String?> { countrySubject.asObserver() }
    
    var cityObservable: AnyObserver<String?> { citySubject.asObserver() }
    
    var addressObservable: AnyObserver<String?> { addressSubject.asObserver() }
    
    var phoneObservable: AnyObserver<String?> { phoneSubject.asObserver() }
    
    var isValidForm: Observable<Bool> {
        return Observable.combineLatest( countrySubject, citySubject,addressSubject, phoneSubject) { country, city, address, phone in
            guard country != nil && city != nil && address != nil && phone != nil  else {
                return false
            }
            return !(country!.isEmpty) &&  !(city!.isEmpty) && !(phone!.isEmpty) && !(address!.isEmpty)
        }
    }
    init(_ addressProvider: AddressProvider = AddressClient(),addressNavigationFlow: UpdateAddressNavigationFlow) {
        self.addressProvider = addressProvider
        self.addressNavigationFlow = addressNavigationFlow
        addresses = addressRequestGett.asDriver(onErrorJustReturn: [])

    }
    
    func goToEditAddress(with address: CustomerAddress) {
        self.addressNavigationFlow?.goToUpdateAddressScreen(with: address)
        
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
    
    func updateAddress(_ address:AddressRequestItemPut){
        let user = getUserFromUserDefaults()
        addressProvider.putAddress(with:  user!.id, with: address.id, addressRequest: AddressRequestPut(address: address))
            .subscribe(onNext: { [weak self] result in
                guard let `self` = self else {fatalError()}
                self.addressRequestPost.onNext(result)
                self.addressNavigationFlow?.popEditContorller()
            }, onError: { [weak self] error in
                guard let `self` = self else {fatalError()}
                self.addressRequestPostError.onNext(error)
            })
            .disposed(by: disposeBag)
    }
    func getAddress( ){
        let user = getUserFromUserDefaults()
        addressProvider.getAddress(with:  user!.id)
            .subscribe(onNext: { [weak self] result in
                guard let `self` = self else {fatalError()}
                self.addressRequestGett.onNext(result.addresses)
                print(result)
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
    
    func goToEditAddressScreen(with address: CustomerAddress) {
        self.addressNavigationFlow?.goToUpdateAddressScreen(with: address)
    }
}
