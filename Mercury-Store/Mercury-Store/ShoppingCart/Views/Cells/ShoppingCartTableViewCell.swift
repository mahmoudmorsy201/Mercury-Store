//
//  ShoppingCartTableViewCell.swift
//  Mercury-Store
//
//  Created by mac hub on 26/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ShoppingCartTableViewCell: UITableViewCell {
    @IBOutlet weak private var containerViewForProductImage: UIView!
    
    @IBOutlet weak private var productImageCart: UIImageView!
    
    @IBOutlet weak private var productNameCart: UILabel!
    
    @IBOutlet weak var containerViewForShoppingCartCell: UIView!
    
    @IBOutlet weak private var productPriceCart: UILabel!
    
    @IBOutlet weak private var stackViewForQuantity: UIStackView!
    
    @IBOutlet weak private var quantityLabel: UILabel!
    
    @IBOutlet weak private var increaseQuntityBtn: UIButton!
    
    
    @IBOutlet weak private var decreaseQuantityBtn: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var shoppingItem: ShoppingCartItem? {
        didSet {
            guard let shoppingItem = shoppingItem else {
                return
            }
            productNameCart.text = shoppingItem.productName
            productPriceCart.text = "\(shoppingItem.productPrice)"
            productImageCart.image = UIImage(named: shoppingItem.imageName)
            quantityLabel.text = "\(shoppingItem.quantity)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupCell() {
        self.containerViewForShoppingCartCell.applyShadow(cornerRadius: 12)
        self.productImageCart.layer.cornerRadius = 12
        self.containerViewForShoppingCartCell.layer.borderWidth = 0.5
        self.containerViewForShoppingCartCell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.stackViewForQuantity.layer.cornerRadius = 8
        self.productImageCart.layer.borderWidth = 0.5
        self.productImageCart.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
    
    func configure(with factory: @escaping (CellInput) -> CellViewModel) {
        // create the input object
        
        let input = CellInput(
            plus: increaseQuntityBtn.rx.tap.asObservable(),
            minus: decreaseQuantityBtn.rx.tap.asObservable(),
            delete: deleteBtn.rx.tap.asObservable()
        )
        // create the view model from the factory
        let viewModel = factory(input)
        // bind the view model's label property to the label
        viewModel.label
            .bind(to: quantityLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

struct CellInput {
    let plus: Observable<Void>
    let minus: Observable<Void>
    let delete: Observable<Void>
}

struct CellViewModel {
    let label: Observable<String>
    let value: Observable<Int>
    let delete: Observable<Void>
}

extension CellViewModel {
    init(_ input: CellInput, initialValue: ShoppingCartItem) {
        let add = input.plus.map { 1 }// plus adds one to the value
        let subtract = input.minus.map { -1 }// minus subtracts one
        
        value = Observable.merge(add,subtract)
            .scan(initialValue.quantity, accumulator: +)
            .filter{$0 > 0}
        
        
        
        
        label = value
            .map {"\($0)"}
        
        delete = input.delete
    }
}

struct CartCellViewModel {
    var image: String
    var name: String
    var price: String
    var count: String
    let product: ShoppingCartItem
    init(usingModel model: ShoppingCartItem) {
        self.product = model
        self.image = model.imageName
        self.name = model.productName
        self.price = "\(model.productPrice)"
        self.count = "\(model.quantity)"
    }
}

extension Int {
    var decimalCurrency: Double {
        return Double(self) / 100.0
    }
    
    var decimalCurrencyString: String {
        let locale = Locale.current
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = locale.currencyCode
        numberFormatter.locale = locale
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        guard let value = numberFormatter.string(from: NSNumber(value: decimalCurrency)) else { fatalError("Could not format decimal currency: \( decimalCurrency)") }
        guard let symbol = locale.currencySymbol else { fatalError("Could not find currency symbol for locale: \(locale)") }
        return "\(symbol)\(value)"
    }
}


    
    
