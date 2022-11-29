//
//  HomeView.swift
//  Home
//
//  Created by Doan Thieu on 16/11/2022.
//

import SharedModels
import Styleguide
import SwiftUI

public struct HomeView: View {

    @State private var isLoading = true
    @State private var selectedIndex = 0
    private var selectedTabIndex: Binding<Int> {
        .init(
            get: { selectedIndex },
            set: { newValue in withAnimation { selectedIndex = newValue } }
        )
    }

    @State private var surveys: [Survey] = Survey.sampleData
    private var selectedSurvey: Survey { surveys[selectedIndex] }

    public init() {}

    public var body: some View {
        ZStack {
            background
                .ignoresSafeArea()

            HomePlaceholderView()
                .padding(.horizontal, 20.0)
                .padding(.bottom, 20.0)
                .renderedIf(isLoading)

            VStack {
                TabView(selection: selectedTabIndex) {
                    ForEach(0..<surveys.count, id: \.self) {
                        SurveyCoverImageView(imageUrl: selectedSurvey.coverImageURL)
                            .tag($0)
                            .ignoresSafeArea()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .ignoresSafeArea()
            }
            .renderedIf(!isLoading)

            VStack {
                header
                Spacer()

                VStack(alignment: .leading, spacing: 24.0) {
                    PageControlView(
                        numberOfPages: surveys.count,
                        currentPage: selectedTabIndex
                    )
                    .frame(width: .zero, height: 8.0, alignment: .leading)
                    .offset(x: -23.67)  // Hack!

                    footer
                }
            }
            .padding(.horizontal, 20.0)
            .padding(.bottom, 20.0)
            .renderedIf(!isLoading)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2_500)) {
                isLoading = false
            }
        }
    }
}

extension HomeView {

    private var background: some View {
        OverlayView(
            colors: [
                .black.opacity(1.0),
                .black.opacity(0.8),
                .black.opacity(1.0)
            ]
        )
    }

    private var header: some View {
        // TODO: Remove hard-coded text
        VStack(alignment: .leading, spacing: 4.0) {
            Text("MONDAY, NOV 21")
                .adaptiveFont(.neuzeitHeavy, size: 13.0)
                .foregroundColor(.white)

            HStack {
                Text("TODAY")
                    .adaptiveFont(.neuzeitHeavy, size: 34.0)
                    .foregroundColor(.white)

                Spacer()

                Asset.Images.avatar.swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 36.0, height: 36.0)
                    .cornerRadius(18.0)
            }
        }
    }

    private var footer: some View {
        HStack(alignment: .bottom, spacing: 20.0) {
            VStack(alignment: .leading, spacing: 16.0) {
                Text(selectedSurvey.title)
                    .adaptiveFont(.neuzeitHeavy, size: 28.0)
                    .foregroundColor(.white)
                    .lineLimit(2)

                Text(selectedSurvey.description)
                    .adaptiveFont(.neuzeitBook, size: 17.0)
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(2)
            }

            Spacer()

            VStack {
                Button(action: {
                    // TODO: Navigate to Survey detail
                }, label: {
                    Asset.Images.chevronRight.swiftUIImage
                        .renderingMode(.original)
                })
                .frame(width: 56.0, height: 56.0)
                .background(Color.white)
                .cornerRadius(.infinity)
            }
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {

    static var previews: some View {
        HomeView()
    }
}
#endif
