import UIKit
import FirebaseAuth
import FirebaseFirestore

struct CreateUser {
   static func createUser (with fullName: String, _ email: String, _ password: String, createUserHandler: @escaping ((Bool) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err = error, authResult == nil {
                print(err.localizedDescription)
                createUserHandler(false)
            } else {
                createUserHandler(true)
            }
        }
        Firestore.firestore().collection("users").addDocument(data: ["email": email, "fullName": fullName]) { error in
            guard let error = error else { return }
            print(error.localizedDescription)
        }
    }
}
