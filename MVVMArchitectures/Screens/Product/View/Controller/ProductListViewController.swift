//
//  ProductListViewController.swift
//  MVVMArchitectures
//
//  Created by intern on 9/24/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    private var viewModel = ProductViewModel()
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        productTableView.delegate = self
        productTableView.dataSource = self
        
        initViewModel()
        observeEvent()
    }
}

extension ProductListViewController {

    func initViewModel() {
        viewModel.fetchProducts()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else {
                return
            }
            switch event {
            case .loading:
                print("Product Loading ...")
            case .stopLoading:
                print("Stop loading ...")
            case .dataLoaded:
                print("Data loaded ...")
                DispatchQueue.main.async {
                    //UI Main works well
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
}
