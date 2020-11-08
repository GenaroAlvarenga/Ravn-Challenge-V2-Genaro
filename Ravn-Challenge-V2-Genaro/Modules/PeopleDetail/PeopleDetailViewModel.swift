//
//  PeopleDetailViewModel.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/8/20.
//

import Foundation
import Combine
import CombineExt

class PeopleDetailViewModel: ObservableObject {
    @Published var detail = StarWarsPersonDetail()
    @Published var isLoading = false
    @Published var error: Error?
    @Published var showAlert = false
    
    private var subscriptions = Set<AnyCancellable>()
    private let detailService: PeopleDetailServiceType
    let fetchPeopleRequest = PassthroughRelay<Void>()
    let peopleID: String
    
    init(detailService: PeopleDetailServiceType = PeopleDetailService(), peopleID: String) {
        self.detailService = detailService
        self.peopleID = peopleID
        
        let detailResult = fetchPeopleRequest
            .flatMapLatest {
                detailService.getDetail(from: peopleID).materialize()
            }
            .share()
        
        let succes = detailResult
            .values()
            .assign(to: \.detail, on: self, ownership: .weak)
            .store(in: &subscriptions)
        
        let error = detailResult
            .failures()
            .sink { [weak self] error in
                self?.error = error
                self?.showAlert = true
            }
            .store(in: &subscriptions)
        
        fetchPeopleRequest
            .map { _ in true }
            .merge(with: detailResult.map { _ in false })
            .assign(to: \.isLoading, on: self, ownership: .weak)
            .store(in: &subscriptions)
    }
    
}
