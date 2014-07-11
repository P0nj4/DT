//
//  NSDate+CommonDateFunctions.m
//  PedidosYa!
//
//  Created by Germán Pereyra on 03/07/14.
//  Copyright (c) 2014 PedidosYa. All rights reserved.
//

#import "NSDate+CommonDateFunctions.h"

@implementation NSDate (CommonDateFunctions)

- (NSDateComponents *)getComponentsOfDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit) fromDate:self];
    return components;
}

- (NSDate *)dateByAddingMinutes:(NSInteger)mins{
    return [self dateByAddingTimeInterval:60*mins];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours{
    return [self dateByAddingTimeInterval:60*60*hours];
}

- (NSDate *)dateByAddingDays:(NSInteger)days{
    return [self dateByAddingTimeInterval:60*60*24*days];
}

- (NSDate *)dateBySubstractingMinutes:(NSInteger)mins{
    return [self dateByAddingTimeInterval:60*mins*-1];
}

- (NSDate *)dateBySubstractingHours:(NSInteger)hours{
    return [self dateByAddingTimeInterval:60*60*hours-1];
}

- (NSDate *)dateBySubstractingDays:(NSInteger)days{
    return [self dateByAddingTimeInterval:60*60*24*days-1];
}

- (NSString *)stringOfDateByCountryCode:(NSString *)country{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([country isEqual:@"VE"] || [country isEqual:@"PR"] || [country isEqual:@"CO"]) {
        [formatter setDateFormat:@"hh:mm a"];
    }else{
        [formatter setDateFormat:@"HH:mm"];
    }
    return [formatter stringFromDate:self];
}

- (BOOL)isGreaterThan:(NSDate *)date{
    if([self timeIntervalSinceDate:date] > 0 ) {
        return YES;
    }
    return NO;
}
@end
