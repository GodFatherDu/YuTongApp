//
//  OpenUDID.h
//  YuTongApp
//
//  Created by bszx on 2017/9/13.
//  Copyright © 2017年 杜小猛. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kOpenUDIDErrorNone          0
#define kOpenUDIDErrorOptedOut      1
#define kOpenUDIDErrorCompromised   2

@interface OpenUDID : NSObject{

}

+ (NSString*) value;
+ (NSString*) valueWithError:(NSError**)error;
+ (void) setOptOut:(BOOL)optOutValue;

@end
