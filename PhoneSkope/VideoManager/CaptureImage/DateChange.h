//
//  DateChange.h
//  HoiAnTravel
//
//  Created by Mobioneer HV 02 on 2/26/13.
//  Copyright (c) 2013 Mobioneer HV 02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateChange : NSObject
+ (int)getMinute:(NSDate*)date;
+ (int)getHour:(NSDate*)date;
+ (int)getDay:(NSDate*)date;
+ (int)getMonth:(NSDate*)date;
+ (int)getYear:(NSDate*)date;
+ (NSDate*)getCurrentDate;
+ (NSString*)getNameMonth:(NSDate*)date;
+ (NSString*)getNameDay:(NSDate*)date;
+ (NSDate*)nextDate:(NSDate*)date;
+ (NSDate*)previewDate:(NSDate*)date;
+ (NSString*)getDayToString:(NSDate*)date;
+ (NSString*)getHourToString:(NSDate*)date Noon:(BOOL)isNoon;
+ (NSString*)getMinuteToString:(NSDate*)date;
+ (NSString*)getNoon:(NSDate*)date;
+ (BOOL) compareDate:(NSDate*)date1 Date:(NSDate*)date2;
+ (NSDate*)operaratorDate:(NSDate*)date Number:(int)value;
+ (NSString*)parseDate:(NSDate*)date;
+ (NSString*)parseDateNotNameDate:(NSDate*)date;
@end
