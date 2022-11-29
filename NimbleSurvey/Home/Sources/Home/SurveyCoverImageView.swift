//
//  SurveyCoverImageView.swift
//  Home
//
//  Created by Doan Thieu on 17/11/2022.
//

import SharedModels
import Styleguide
import SwiftUI

struct SurveyCoverImageView: View {

    let imageUrl: URL?

    var body: some View {
        AsyncImage(url: imageUrl) { phase in
            switch phase {
            case let .success(image):
                image
                    .resizable()
                    .overlay(overlay)
                    .background(Color.black)
            default:
                EmptyView()
            }
        }
    }
}

extension SurveyCoverImageView {

    private var overlay: some View {
        OverlayView(
            colors: [
                .black.opacity(0.4),
                .black.opacity(0),
                .black.opacity(0),
                .black.opacity(0),
                .black.opacity(0.4),
                .black.opacity(0.4)
            ]
        )
    }
}

#if DEBUG
struct SurveyCoverImageView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SurveyCoverImageView(imageUrl: Survey.sampleData.first?.coverImageURL)
                .ignoresSafeArea()
        }
    }
}
#endif
