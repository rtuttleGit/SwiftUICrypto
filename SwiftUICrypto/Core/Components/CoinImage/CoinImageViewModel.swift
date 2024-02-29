//
//  CoinImageViewModel.swift
//  SwiftUICrypto
//
//  Created by M29002 on 24/6/23.
//

import Foundation
import UIKit
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        addSubscribers()
        self.isLoading = true
    }
    
    func addSubscribers() {
        dataService.$image
            .sink { [weak self] (response) in
                print("response: \(response)")
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                print("Fox3")
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
