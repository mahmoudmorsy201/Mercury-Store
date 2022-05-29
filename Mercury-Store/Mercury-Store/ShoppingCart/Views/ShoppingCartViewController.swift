//
//  ShoppingCartViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ShoppingCartViewController: UIViewController, ShoppingCartCoordinated {
    
    @IBOutlet weak private var totalPriceLabel: UILabel!
    
    
    @IBOutlet weak private var shoppingCartTableView: UITableView! {
        didSet {
            shoppingCartTableView.register(UINib(nibName: ShoppingCartTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: ShoppingCartTableViewCell.reuseIdentifier())
        }
    }
    
    
    @IBOutlet weak private var proceedToCheckoutBtn: UIButton!
    
    var coordinator: ShoppingCartBaseCoordinator?
    
    
    private var disposeBag = DisposeBag()
    
    
    let value = PublishSubject<(id: UUID, value: Int)>()
    let delete = PublishSubject<UUID>()
    let repo = ShoppingCartRepository()
    let refreshControl = UIRefreshControl()
    
    init(coordinator: ShoppingCartBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        
        self.coordinator = coordinator
        title = "Cart"

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func bind() {
        shoppingCartTableView.delegate = nil
        shoppingCartTableView.dataSource = nil
        shoppingCartTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let value = self.value
        let delete = self.delete
        let addInput = Observable.merge(
            rx.methodInvoked(#selector(viewWillAppear(_:))).map { _ in },
            refreshControl.rx.controlEvent(.valueChanged).delay(.seconds(2), scheduler: MainScheduler.instance).asObservable()
        )
        
        let input = Input(
            value: value,
            delete: delete,
            add: addInput
        )
        
        let viewModel = ViewModel(input, refreshTask: self.repo.refreshValues)
    
        viewModel.counters.drive(shoppingCartTableView.rx.items(cellIdentifier: ShoppingCartTableViewCell.reuseIdentifier(), cellType: ShoppingCartTableViewCell.self)) {
            index, element , cell in
            cell.shoppingItem = element
            cell.configure { input in
                let vm = CellViewModel(input, initialValue: element)
                // Remember the value property tracks the current value of the counter
                vm.value
                    .map { (id: element.id, value: $0) } // tell the main view model which counter's value this is
                    .bind(to: value)
                    .disposed(by: cell.disposeBag)
                
                vm.delete
                    .map { element.id } // tell the main view model which counter should be deleted
                    .bind(to: delete)
                    .disposed(by: cell.disposeBag)
                return vm // han
            }
            
        }.disposed(by: disposeBag)
        
        viewModel.counters
            .map { _ in false}
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
    
    
}

extension ShoppingCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
}



extension ShoppingCartViewController {
    
    func configureView() {
        title = "Cart"
        
        shoppingCartTableView.delegate = nil
        shoppingCartTableView.dataSource = nil
        shoppingCartTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        shoppingCartTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        shoppingCartTableView.tableFooterView = UIView()
    }
    
    fileprivate func checkout() -> Observable<UIViewController.AlertAction> {
        return alert(title: "Complete Order",
                     message: "Would you like to checkout now and complete your order?",
                     defaultTitle: "Checkout",
                     cancelTitle: "Cancel")
    }
        
}

extension UIViewController {
    enum AlertAction {
        case `default`
        case cancel
    }
    
    func alert(title: String? = nil, message: String, defaultTitle: String, cancelTitle: String = "Cancel") -> Observable<AlertAction> {
        return Observable.create { [weak self] observable in
            let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: defaultTitle, style: .default, handler: { _ in
                observable.onNext(.default)
                observable.onCompleted()
            }))
            vc.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { _ in
                observable.onNext(.cancel)
                observable.onCompleted()
            }))
            self?.present(vc, animated: true)
            return Disposables.create {
                self?.dismiss(animated: true)
            }
        }
    }
}


extension UITableView {
    
    func setEmptyState(message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.textAlignment = .center
        label.text = message
     

        self.isScrollEnabled = false
        self.backgroundView = label
        self.separatorStyle = .none
    }
    
    func removeEmptyState() {
        self.isScrollEnabled = true
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension Reactive where Base: UITableView {
    
    func isEmpty(message: String) -> Binder<Bool> {
        return Binder(base) { tableView, isEmpty in
            if isEmpty {
                tableView.setEmptyState(message: message)
            } else {
                tableView.removeEmptyState()
            }
        }
    }
}


