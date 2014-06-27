//
//  CommonValidations.h
//  PedidosYa!
//
//  Created by Germán Pereyra on 02/04/13.
//  Copyright (c) 2013 PedidosYa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonValidations : NSObject

+ (BOOL)validateColAddres:(NSString*)candidate;
+ (BOOL)validateAlphanumeric:(NSString *)candidate;
+ (BOOL)validateStringInCharacterSet:(NSString *)string characterSet:(NSMutableCharacterSet *)characterSet;
+ (BOOL)validateMinimumLength:(NSString *)candidate parameter:(NSInteger)length;
+ (BOOL)validateNumber:(NSString*)candidate;
+ (BOOL)validateAlphaSpaces:(NSString *)candidate;
+ (BOOL)validateNotEmpty:(NSString *)candidate;
+ (BOOL)validateAddress:(NSString*)candidate;
+ (BOOL)validateCarrier:(NSString*)candidate;
+ (BOOL)validateCEP:(NSString*)candidate;
+ (BOOL)validateEmail:(NSString *)candidate;
+ (BOOL)validateCPF:(NSString *)candidate;
+ (NSString*)validateSMSphone:(NSString *)candidate;
@end
