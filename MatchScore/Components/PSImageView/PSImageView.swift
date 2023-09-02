//
//  PSImageView.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import SwiftUI

enum ImageSize {
    case small
    case regular
    case large
    
    var value: CGFloat {
        switch self {
        case .small:
            return CGFloat(16)
        case .regular:
            return CGFloat(48)
        case .large:
            return CGFloat(60)
        }
    }
}

struct PSImageView: View {
    
    @StateObject private var imageViewModel: PSImageViewModel
    
    @Environment(\.controlSize)
        var controlSize
    
    var size: ImageSize {
        switch controlSize {
        case .small:
            return .small
        case .regular:
            return .regular
        case .large:
            return .large
        default:
            return .small
        }
    }
    
    var placeHolderRadius: CGFloat {
        switch controlSize {
        case .mini, .small, .regular:
            return CGFloat(12)
        case .large:
            return CGFloat(30)
        default:
            return CGFloat(30)
        }
    }
    
    init(imageUrl: String?) {
        _imageViewModel = StateObject(wrappedValue: PSImageViewModel(imageUrl: imageUrl))
    }
    
    var body: some View {
        VStack {
            if imageViewModel.loadingImage {
                ProgressView()
                    .frame(width: size.value, height: size.value)
            } else if let image = imageViewModel.image {
                image
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: size.value, height: size.value)
                    .aspectRatio(contentMode: .fit)
            } else {
                VStack{}
                    .frame(width: size.value, height: size.value)
                    .background(Color.placeholderColor)
                    .cornerRadius(placeHolderRadius)
            }
        }
        .onAppear(perform: imageViewModel.onAppear)
    }
}

struct PSImageView_Previews: PreviewProvider {
    static var previews: some View {
        PSImageView(imageUrl: "")
    }
}
