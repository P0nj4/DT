//
//  CommonValidations.m
//  PedidosYa!
//
//  Created by Germán Pereyra on 02/04/13.
//  Copyright (c) 2013 PedidosYa. All rights reserved.
//

#import "CommonValidations.h"


@implementation CommonValidations

+ (BOOL)validateEmail:(NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}


+ (BOOL)validateCellphone:(NSString*)candidate {
    NSString *emailRegex = @"[0-9]{3}+-[0-9]{3}+-[0-9-]{4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)validateCEP:(NSString*)candidate {
    NSString *emailRegex = @"[0-9]{5}-[0-9]{3}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)validateCarrier:(NSString*)candidate {
    return [candidate compare:@"Operador" options:NSCaseInsensitiveSearch];
}

+ (BOOL)validateAddress:(NSString*)candidate {
    NSString *addressRegex = @"[\\p{L}._ 0-9]+ [0-9]+";
    addressRegex = [addressRegex stringByTrimmingCharactersInSet:
                    [NSCharacterSet whitespaceCharacterSet]];
    NSPredicate *addressTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", addressRegex];
    return [addressTest evaluateWithObject:candidate];
}

+ (BOOL)validateNotEmpty:(NSString *)candidate {   
    return ([candidate stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) ? NO : YES;
}

+ (BOOL)validateCPF:(NSString *)candidate {
    candidate = [candidate stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [candidate length])];

    if (candidate.length != 11) { return false; }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [candidate length]; i++) {
        [array addObject:[NSString stringWithFormat:@"%C", [candidate characterAtIndex:i]]];
    }
    
    int total = 0;
    int resto = 0;
    for (int i = 0; i < 9; i++)
    {
        total += ([[array objectAtIndex:i] intValue]) * (i + 1);
    }
    resto = total % 11;
    if (resto >= 10) { resto = 0; }
    
    
    if (!(resto == [[array objectAtIndex:9] intValue])) { return false; }
    
    total = 0;
    for (int i = 0; i < 10; i++)
    {
        total += [[array objectAtIndex:i] intValue] * (i);
    }
    resto = total % 11;
    if (resto >= 10) { resto = 0; }
    if (!(resto == [[array objectAtIndex:10] intValue])) { return false; }
    return true;
}


+ (BOOL)validateAlphaSpaces:(NSString *)candidate {
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet letterCharacterSet];
    [characterSet addCharactersInString:@" "];
    return [CommonValidations validateStringInCharacterSet:candidate characterSet:characterSet];
}


+ (BOOL)validateNumber:(NSString*)candidate {
    NSString *emailRegex = @"[0-9]*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}


+ (BOOL)validateMinimumLength:(NSString *)candidate parameter:(NSInteger)length {
    return ([candidate length] >= length) ? YES : NO;
}


+ (BOOL)validateStringInCharacterSet:(NSString *)string characterSet:(NSMutableCharacterSet *)characterSet {
    return ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) ? NO : YES;
}


+ (BOOL)validateAlphanumeric:(NSString *)candidate {
    return [self validateStringInCharacterSet:candidate characterSet:[NSCharacterSet alphanumericCharacterSet]];
}

+ (BOOL)validateColAddres:(NSString*)candidate{
    
    NSArray *aux = [candidate componentsSeparatedByString:@" "];
    
    if ([aux count] < 2) {
        return NO;
    }
    
    NSString *lastWord = [aux objectAtIndex:[aux count]-1];
    
    if ([lastWord rangeOfString:@"-"].location == NSNotFound){
        return NO;
    }
    else{
        return YES;
    }
}


@end
