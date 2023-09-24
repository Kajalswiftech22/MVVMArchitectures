//
//  ProductViewModel.swift
//  MVVMArchitectures
//
//  Created by intern on 9/24/23.
//

import Foundation

final class ProductViewModel {
    
    var products: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)?  //Data Binding Closure
    
    func fetchProducts() {
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: [Product].self,
            type: EndPointItems.products) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let products):
                    self.products = products
                    self.eventHandler?(.dataLoaded)
                case.failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
    /*
    func fetchProducts() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchProducts { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoaded)
            case.failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
     */
}

extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
