//
//  Model.swift
//  CryptoParser
//
//  Created by Anton Asetski on 2/19/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import Foundation

class Model {

    var currencies = Currency()
    private let kernel: Kernel?

    init(_ kernel: Kernel) {
        self.kernel = kernel
    }

    func refresh() {
        self.kernel?.network.getCurrencies() { response in
            switch response {
            case .success(let currencys):
                for item in 0...currencys.count - 1 {
                    // TODO: - Fix array adding
                    if self.currencies.contains(currencys[item]) {
                        self.currencies[item] = currencys[item]
                    }
                }
                NotificationCenter.default.post(name: Notification.Name("Reload"), object: nil)
            case .failure(let error):
                print(error)
            }
        }
    }

    func delete(at index: Int) {
        self.currencies.remove(at: index)
    }

    func addToFavourite(from array: Currency) {
        for item in array {
            if self.currencies.contains(item) {
                continue
            } else {
                self.currencies.append(item)
            }
        }
    }
}
