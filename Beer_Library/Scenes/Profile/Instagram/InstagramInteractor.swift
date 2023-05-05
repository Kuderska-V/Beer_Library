//
//  InstagramInteractor.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 05.05.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol InstagramBusinessLogic {
  
    func getTestUserIDandToken(request: Instagram.User.Request)
    func getInstagramUser()
    func fetchPhoto()
}

protocol InstagramDataStore {
  //var name: String { get set }
}

class InstagramInteractor: InstagramBusinessLogic, InstagramDataStore {
  var presenter: InstagramPresentationLogic?
  var worker: InstagramWorker?
    var instagramUser: InstagramUser?
    var instagramApi = InstagramApi.shared
    var testUserData: InstagramTestUser?
    var mainVC: ProfileViewController?
  
  // MARK: Do something
    
    func getTestUserIDandToken(request: Instagram.User.Request) {
        let request = request.request
        self.instagramApi.getTestUserIDAndToken(request: request) { [weak self] (instagramTestUser) in
            self?.testUserData = instagramTestUser
            DispatchQueue.main.async {
                self!.presenter?.dismissViewController()
            }
            self!.getInstagramUser()
        }
    }
  
  func getInstagramUser() {
      self.instagramApi.getInstagramUser(testUserData: self.testUserData!) { [weak self] (user) in
          self?.instagramUser = user
      }
  }
    
    func fetchPhoto() {
        self.mainVC?.testUserData = self.testUserData!
        
        guard self.instagramUser != nil else { return }
        self.instagramApi.getMedia(testUserData: self.testUserData!, index: 0) { (media) in
                guard media.media_type != MediaType.VIDEO else { return }
                let media_url = media.media_url
                self.instagramApi.fetchImage(urlString: media_url, completion: { (fetchedImage) in
                    guard let fetchedImage else { return }
                    DispatchQueue.main.async {
                        //self.mainVC?.imageInstagram.image = UIImage(data: fetchedImage)
                        let response = Instagram.User.Response(image: fetchedImage)
                        self.presenter?.presentPhoto(response: response)
                    }
                    print("\(fetchedImage)")
            })
        }
    }

}
