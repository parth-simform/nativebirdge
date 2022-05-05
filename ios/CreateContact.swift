//
//  CreateContact.swift
//  nativebridge
//
//  Created by Parth Shah on 05/05/22.
//

import Foundation
import UIKit
import Contacts

@objc(CreateContact)

class CreateContact: NSObject, RCTBridgeModule {
  
   var cName: String = ""
   var cNumber: String = ""
  var cFamily: String = ""
  var cEmail: String = ""
  let contact = CNMutableContact()
  
  static func moduleName() -> String!{
    return "CreateContact";
  }
  
  static func requiresMainQueueSetup() -> Bool {
    return true;
  }
  
  @objc
  func createContact(_ name:String ,familyName:String , number:String , email:String) -> Void{
    cName = name
    cFamily = familyName
    cNumber = number
    cEmail = email
    self.collectData()
  }
  
  @objc
  func collectData(){
    // Contact name prefix
            contact.namePrefix = "Mr."
            
            // Contact first name
            contact.givenName = cName
            
            // Contact last name
            contact.familyName = cFamily
            
            // Contact profile picture
//    let imageData = #imageLiteral(resourceName: "profilePicture").pngData()
//            contact.imageData = imageData
            
            // Contact Address Details
            let postalAddress = CNMutablePostalAddress()
            postalAddress.street = "1 Infinite Loop"
            postalAddress.city = "Cupertino"
            postalAddress.state = "CA"
            postalAddress.postalCode = "95014"
            contact.postalAddresses = [CNLabeledValue(label:CNLabelWork, value:postalAddress)]
            
            // Contact Phone numbers
            contact.phoneNumbers = [CNLabeledValue(
                label:CNLabelPhoneNumberiPhone,
                value:CNPhoneNumber(stringValue: cNumber ))]
            
            // Contact Email addresses
            let homeEmailAddress = CNLabeledValue(label: CNLabelHome, value: cEmail as NSString)
            let workEmailAddress = CNLabeledValue(label: CNLabelHome, value: cEmail as NSString)
            contact.emailAddresses = [homeEmailAddress, workEmailAddress]
            
            // Contact Birthday
            var birthday = DateComponents()
            birthday.day = 2
            birthday.month = 10
            birthday.year = 1991
            contact.birthday = birthday
            
            // Saving the newly created contact
            let store = CNContactStore()
            let saveRequest = CNSaveRequest()
            saveRequest.add(contact, toContainerWithIdentifier:nil)
            try! store.execute(saveRequest)
   
  }
}
