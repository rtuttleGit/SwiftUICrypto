//
//  DetailViewModel.swift
//  SwiftUICrypto
//
//  Created by M29002 on 27/8/23.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    private let coinDetailServices: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    @Published var coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailServices = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailServices.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArray in
                print(returnedArray.overview)
                self?.overviewStatistics = returnedArray.overview
                self?.additionalStatistics = returnedArray.additional
        }
        .store(in: &cancellables)
        
        coinDetailServices.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        return (createOverviewArray(coinDetailModel: coinDetailModel, coinModel: coinModel), createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel))
    }
    
    private func createOverviewArray(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel] {
        //overview
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentage = coinModel.marketCapChange24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentage)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        return [priceStat, marketCapStat, rankStat, volumeStat]
    }
    
    private func createAdditionalArray(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel] {
        //additional
        let high24 = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h high", value: high24)
        
        let low24 = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h low", value: low24)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentage = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentage)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeStr = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeStr)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algo", value: hashing)
        
        return [highStat, lowStat, priceChangeeStat, marketCapChangeStat, blockStat, hashingStat]
    }
}
