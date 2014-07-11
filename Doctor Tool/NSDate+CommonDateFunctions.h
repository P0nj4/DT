//
//  NSDate+CommonDateFunctions.h
//  PedidosYa!
//
//  Created by Germán Pereyra on 03/07/14.
//  Copyright (c) 2014 PedidosYa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CommonDateFunctions)
- (NSDateComponents *)getComponentsOfDate;
- (NSDate *)dateByAddingMinutes:(NSInteger)mins;
- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateByAddingDays:(NSInteger)days;

- (NSDate *)dateBySubstractingMinutes:(NSInteger)mins;
- (NSDate *)dateBySubstractingHours:(NSInteger)hours;
- (NSDate *)dateBySubstractingDays:(NSInteger)days;

- (NSString *)stringOfDateByCountryCode:(NSString *)country;
- (BOOL)isGreaterThan:(NSDate *)date;
@end
