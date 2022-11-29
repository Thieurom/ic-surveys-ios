//
//  SurveyDetailView.swift
//  Survey
//
//  Created by Doan Thieu on 22/11/2022.
//

import SharedModels
import Styleguide
import SwiftUI

public struct SurveyDetailView: View {

    let survey: Survey

    public init(survey: Survey) {
        self.survey = survey
    }

    public var body: some View {
        ZStack {
            surveyAnswers

            VStack(alignment: .leading, spacing: 0) {
                header
                surveyQuestion
                Spacer()
                Spacer()
                footer

            }
            .padding(.horizontal, 20.0)
        }
    }
}

extension SurveyDetailView {

    private var header: some View {
        HStack {
            Spacer()
            Button(action: {
                // TODO: Close the question
            }, label: {
                Asset.Images.close.swiftUIImage
                    .renderingMode(.original)
                    .frame(width: 28.0, height: 28.0)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(.infinity)
            })
        }
        .padding(.bottom, 32.0)
    }

    private var surveyAnswers: some View {
        TabView {
            FivePointsRatingView(style: .star, value: .constant(3))
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(
            AsyncImage(url: survey.coverImageURL) { phase in
                switch phase {
                case let .success(image):
                    image
                        .resizable()
                        .overlay(OverlayView(colors: [.black.opacity(0.2), .black.opacity(0.1)]))
                        .background(Color.black)
                default:
                    EmptyView()
                }
            }
        )
        .ignoresSafeArea()
    }

    private var surveyQuestion: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text("1/5")
                .adaptiveFont(.neuzeitBook, size: 17.0)
                .foregroundColor(.white.opacity(0.7))

            Text("How did WFH change your productivity?")
                .adaptiveFont(.neuzeitHeavy, size: 34.0)
                .foregroundColor(.white)
        }
    }

    private var footer: some View {
        HStack {
            Spacer()

            Button(action: {
                // TODO: Move to next question
            }, label: {
                Asset.Images.chevronRight.swiftUIImage
                    .renderingMode(.original)
            })
            .buttonStyle(CircleButtonStyle())
        }
        .padding(.bottom, 20.0)
    }
}

#if DEBUG
struct SurveyDetailView_Previews: PreviewProvider {

    static var previews: some View {
        SurveyDetailView(survey: .sampleData[0])
    }
}
#endif

