//
//  Survey.swift
//  Home
//
//  Created by Doan Thieu on 17/11/2022.
//

import Foundation

struct Survey: Equatable {

    let title: String
    let description: String
    let coverImageURL: URL?
}

extension Survey {

    static let sampleData: [Survey] = [
        .init(
            title: "Working from home Check-In",
            description: "We would like to know how you feel about our work from home",
            coverImageURL: URL(string: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l")
        ),
        .init(
            title: "Career training and development",
            description: "We would like to know what are your goals and skills you wanted",
            coverImageURL: URL(string: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l")
        ),
        .init(
            title: "Inclusion and belonging",
            description: "Building a workplace culture that prioritizes belonging and inclusion",
            coverImageURL: URL(string: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l")
        )
    ]
}
