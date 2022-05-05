//
//  CreateContact.m
//  nativebridge
//
//  Created by Parth Shah on 05/05/22.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(CreateContact, NSObject)
RCT_EXTERN_METHOD(createContact:(NSString *)name familyName:(NSString *)familyName number:(NSString *)number email:(NSString *)email)
@end
