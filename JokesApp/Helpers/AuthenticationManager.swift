//
//  AuthentificationManager.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 16.01.2023.
//

import Foundation
import FirebaseAuth

class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    func createUser(email: String, password: String, completion: ((Error?) -> ())? = nil) {
          Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
              if let error = error{
                  completion?(error)
                  return
              }
              completion?(nil)
          }
    }
    
    func login(withEmail email: String, password: String, completion: ((Error?) -> ())? = nil) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion?(error)
                return
            }
            completion?(nil)
        }
    }
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
    
    func sendEmailVerification(completion: ((Error?) -> ())? = nil) {
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            completion?(error)
        })
    }
    
    func reloadUser(completion: ((Error?) -> ())? = nil) {
        Auth.auth().currentUser?.reload(completion: { (error) in
            completion?(error)
        })
    }
    
    func sendPasswordReset(withEmail email: String, completion: ((Error?) -> ())? = nil) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion?(error)
        }
    }
    
    func createProfileChangeRequest(photoUrl: URL? = nil, name: String? = nil, completion: ((Error?) -> ())? = nil) {
        if let request = Auth.auth().currentUser?.createProfileChangeRequest() {
            if let name = name {
                request.displayName = name
            }
            if let url = photoUrl {
                request.photoURL = url
            }
            request.commitChanges(completion: { (error) in
                completion?(error)
            })
        }
    }
    
}
