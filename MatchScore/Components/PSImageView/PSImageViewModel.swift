//
//  PSImageViewModel.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import SwiftUI
import Combine

class PSImageViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var image: Image?
    
    @Published var loadingImage: Bool = false
    
    let imageUrl: String?
    
    init(imageUrl: String?) {
        self.imageUrl = imageUrl
    }
    
    func onAppear() {
        loadingImage = true
        guard let imageUrl = self.imageUrl,
            let imageUrl = URL(string: imageUrl) else {
            loadingImage = false
            return
        }
        
        PSImageLoader.shared.downloadImage(imageUrl)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.loadingImage = false
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] data in
                guard let uiImage = UIImage(data: data) else {
                    return
                }
                let convertedImage = Image(uiImage: uiImage)
                self?.image = convertedImage
            })
            .store(in: &cancellables)
    }
}
