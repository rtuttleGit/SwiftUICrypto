//
//  SettingsView.swift
//  SwiftUICrypto
//
//  Created by M29002 on 2/9/23.
//

import SwiftUI

struct SettingsView: View {
    
    let terms = URL(string: "https://google.com")!
    let privacyPolicy = URL(string: "https://google.com")!
    
    var body: some View {
        NavigationView {
            ZStack {
                //background
                Color.theme.background
                    .ignoresSafeArea()
                List {
                    coinGeckoSection
                    applicationSection
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The Cryptocurrency data used in this app comes from CoinGecko API")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
        }
    }
    
    private var applicationSection: some View  {
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: terms)
            Link("Privacy Policy", destination: privacyPolicy)
        }
    }
}
