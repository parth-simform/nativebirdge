///Users/parthshah/Documents/Demo/nativebridge/ios/HelloWorld.swift
//  Contact.swift
//  nativebridge
//
//  Created by Parth Shah on 04/05/22.
//

import Foundation
import UIKit
import Contacts

@objc(Contact)

class Contact: NSObject, RCTBridgeModule {
  var cName: String = ""
  var cNumber: String = ""
 var cFamily: String = ""
 var cEmail: String = ""
 let contact = CNMutableContact()
  let store = CNContactStore()
  static func moduleName() -> String!{
    return "Contact";
  }
  
  static func requiresMainQueueSetup() -> Bool {
    return true;
  }
  
  @objc
  func getContact(_ callback:RCTResponseSenderBlock){
     let entityType = CNEntityType.contacts
     let authorize=CNContactStore.authorizationStatus(for: entityType)
     if authorize == CNAuthorizationStatus.notDetermined{
       let contactStore = CNContactStore.init()
       contactStore.requestAccess(for: entityType) { (success, nil) in
         if success {
           print("hello this is first")
          
         }
       }
     }
     else if authorize == CNAuthorizationStatus.authorized{
       
       let predicate = CNContact.predicateForContactsInContainer(withIdentifier: store.defaultContainerIdentifier())
       let contact = try! store.unifiedContacts(matching: predicate, keysToFetch: [CNContactFamilyNameKey as CNKeyDescriptor, CNContactGivenNameKey as CNKeyDescriptor,CNContactPhoneNumbersKey as CNKeyDescriptor])
       var newOne : [[String:String]] = []
       for con in contact {
            for ph in con.phoneNumbers{
              let array1 = ["name" : con.givenName ,"familyName": con.familyName, "number" : ph.value.stringValue]
              newOne.append(array1)
            }
          }
       print("newOne\(newOne)")
       callback([newOne])
      
     }
   }
  @objc
  func createContact(_ name:String ,familyName:String , number:String , email:String) -> Void{
    cName = name
    cFamily = familyName
    cNumber = number
    cEmail = email
    self.storeContact()
  }
  
  @objc
  func storeContact(){
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


