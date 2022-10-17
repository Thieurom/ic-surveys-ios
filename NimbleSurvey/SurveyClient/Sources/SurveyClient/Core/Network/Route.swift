//
//  Route.swift
//  SurveyClient
//
//  Created by Doan Thieu on 13/10/2022.
//

import Foundation

protocol Route {

    var url: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var parameters: Parameters? { get }
    var parameterEncoding: ParameterEncoding? { get }
}
