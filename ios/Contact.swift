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
  
  let store = CNContactStore()
  static func moduleName() -> String!{
    return "Contact";
  }
  
  static func requiresMainQueueSetup() -> Bool {
    return true;
  }
  
//  @objc
//  func constantsToExport() -> [AnyHashable: Any]! {
//    return ["contact": 0];
//  }
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
       let contact = try! store.unifiedContacts(matching: predicate, keysToFetch: [CNContactBirthdayKey as CNKeyDescriptor,CNContactFamilyNameKey as CNKeyDescriptor, CNContactGivenNameKey as CNKeyDescriptor,CNContactPhoneNumbersKey as CNKeyDescriptor])
       var newOne : [[String:String]] = []
       for con in contact {
            for ph in con.phoneNumbers{
            let array1 = ["name" : con.givenName, "number" : ph.value.stringValue]
              newOne.append(array1)
            }
          }
       callback([newOne])
      
     }
   }
 }


//struct Details {
//  var name:String
//  var number:String
//  //  var description: String {
//  //    return name
//  //  }
//  init(name:String, number:String)
//  {
//    self.name = name
//    self.number = number
//  }
//  //
//}

//var patientArray: [Patenint] = []
//let detailss = Patenint(name: "parth", number: "5212215")
//patientArray.append(detailss)
//
////    let p = Patenint()
////    p.name = "parth"
////    p.number = "25122"
////    patientArray.append(p)
//print("patientArraypatientArray: \(patientArray)")
//callback([detailss])

//  @objc
//  func getContactList(){
//    let predicate = CNContact.predicateForContactsInContainer(withIdentifier: store.defaultContainerIdentifier())
//    let contact = try! store.unifiedContacts(matching: predicate, keysToFetch: [CNContactBirthdayKey as CNKeyDescriptor,CNContactFamilyNameKey as CNKeyDescriptor, CNContactGivenNameKey as CNKeyDescriptor,CNContactPhoneNumbersKey as CNKeyDescriptor])
//
//    for con in contact {
//      print("contact\(con)")
//      for ph in con.phoneNumbers{
//        print("first name:\(con.givenName)"+"number:\(ph.value.stringValue)")
//      }
//    }
//
//  }
