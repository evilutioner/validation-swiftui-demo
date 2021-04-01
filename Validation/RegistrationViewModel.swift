//
//  RegistrationViewModel.swift
//  Validation
//
//  Created by Oleg Marchik on 31.03.21.
//

import SwiftUI
import Combine

final class RegistrationViewModel: ObservableObject, Identifiable {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var verifiedPassword: String = ""
    @Published private(set) var serverStatusCheck: Bool?
    
    private let scheduler: DispatchQueue
    private var disposables = Set<AnyCancellable>()
    
    var createButtonIsDisabled: Bool {
        isWellKnownPassword || isPasswordTooShort || password != verifiedPassword || serverStatusCheck != true
    }
    
    var isPasswordTooShort: Bool {
        password.count <= 8
    }
    
    var isWellKnownPassword: Bool {
        ["password", "admin"].contains(password)
    }
  
    init(scheduler: DispatchQueue = DispatchQueue(label: "RegistrationViewModel")) {
        self.scheduler = scheduler
        bind()
    }
    
    private func bind() {
        $username.dropFirst()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] userName in
                self?.serverStatusCheck = nil
            })
            .debounce(for: .milliseconds(500), scheduler: scheduler)
            .removeDuplicates()
            .map { [unowned self] userName in
                self.sendRequestToServer(userName: username)
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] serverStatusCheck in
                self?.serverStatusCheck = serverStatusCheck
            })
            .store(in: &disposables)
    }
    
    private func sendRequestToServer(userName: String) -> Future<Bool, Never> {
      return Future { promise in
        promise(.success(userName.count >= 5))
      }
    }
}
