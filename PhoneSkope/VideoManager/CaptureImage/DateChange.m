//
//  DateChange.m
//  HoiAnTravel
//
//  Created by Mobioneer HV 02 on 2/26/13.
//  Copyright (c) 2013 Mobioneer HV 02. All rights reserved.
//

#import "DateChange.h"
@implementation DateChange
+ (NSDate*)getCurrentDate
{
    NSDate* date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"vi_VN"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"MMM dd, yyyy HH:mm"];
    
    NSDate *combinedDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:date]];
    return combinedDate;
}

+ (int)getDay:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"vi_VN"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"dd"];
    
    NSString* dayStr = [dateFormatter stringFromDate:date];
    return [dayStr integerValue];
}

+ (NSString*)getDayToString:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"vi_VN"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"dd"];
    
    NSString* dayStr = [dateFormatter stringFromDate:date];
    if([dayStr integerValue] / 10 == 0)
        return [NSString stringWithFormat:@"0%d",[dayStr integerValue]];
    else
        return [NSString stringWithFormat:@"%d",[dayStr integerValue]];
}
+ (NSString*)getHourToString:(NSDate*)date Noon:(BOOL)isNoon
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"vi_VN"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"HH"];
    
    NSString* dayStr = [dateFormatter stringFromDate:date];
    int ret = [dayStr integerValue];
    if (ret >= 13) 
        ret -= 12;
    if(ret / 10 == 0)
        return [NSString stringWithFormat:@"0%d",ret];
    else
        return [NSString stringWithFormat:@"%d",ret];
}
+ (NSString*)getMinuteToString:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"vi_VN"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"mm"];
    
    NSString* dateStr = [dateFormatter stringFromDate:date];
    if([dateStr integerValue] / 10 == 0)
        return [NSString stringWithFormat:@"0%d",[dateStr integerValue]];
    else
        return [NSString stringWithFormat:@"%d",[dateStr integerValue]];
}
+ (NSString*)getNoon:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"vi_VN"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"HH"];
    
    NSString* dateStr = [dateFormatter stringFromDate:date];
    if( [dateStr integerValue] >= 12)
        return @"PM";
    else
        return @"AM";
}

+ (int)getMonth:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"vi_VN"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"MM"];
    
    NSString* dateStr = [dateFormatter stringFromDate:date];
    return [dateStr integerValue];
}
+ (int)getYear:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"vi_VN"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"YYYY"];
    
    NSString* dateStr = [dateFormatter stringFromDate:date];
    return [dateStr integerValue];
}
+ (int)getMinute:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"vi_VN"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"mm"];
    
    NSString* dateStr = [dateFormatter stringFromDate:date];
    return [dateStr integerValue];
}
+ (int)getHour:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"vi_VN"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"HH"];
    
    NSString* dateStr = [dateFormatter stringFromDate:date];
    return [dateStr integerValue];
}
+ (NSString*)getNameMonth:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"vi_VN"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"MM"];
    
    NSString* dateStr = [dateFormatter stringFromDate:date];
    int dateInt = [dateStr integerValue];
    
    switch (dateInt) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            return @"-";
            break;
    }
}
+ (NSString*)getNameDay:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"vi_VN"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"MM"];
    NSString* dateStr = [dateFormatter stringFromDate:date];
    int monthInt      = [dateStr integerValue];
    
    [dateFormatter setDateFormat:@"dd"];
    dateStr = [dateFormatter stringFromDate:date];
    int dayInt        = [dateStr integerValue];
    
    [dateFormatter setDateFormat:@"yyyy"];
    dateStr = [dateFormatter stringFromDate:date];
    int yearInt        = [dateStr integerValue];
    

    int s = 0;
    
    switch (monthInt - 1) {
        case 11:
            s += 30;
        case 10:
            s += 31;
        case 9:
            s += 30;
        case 8:
            s += 31;
        case 7:
            s += 31;
        case 6:
            s += 30;
        case 5:
            s += 31;
        case 4:
            s += 30;
        case 3:
            s += 31;
        case 2:
            if (yearInt % 4 == 0) 
                s += 29;
            else
                s += 28;
        case 1:
            s += 31;
        default:
            break;
    }
    s += dayInt;
    
    int tmp = yearInt +(int)((yearInt - 1)/4) - (int)((yearInt - 1)/100) + (int)((yearInt - 1)/400) + s;
    int ret = tmp%7;
    switch (ret) {
        case 1:
            return @"Sunday";
            break;
        case 2:
            return @"Monday";
            break;
        case 3:
            return @"Tuesday";
            break;
        case 4:
            return @"Wednesday";
            break;
        case 5:
            return @"Thursday";
            break;
        case 6:
            return @"Friday";
            break;
        default:
            return @"Saturday";
            break;
    }
}
+ (NSDate*)nextDate:(NSDate*)date
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:+1];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *end = [gregorian dateByAddingComponents:components toDate:date options:0];
    
    return end;
}

+ (NSDate*)operaratorDate:(NSDate*)date Number:(int)value
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:value];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *end = [gregorian dateByAddingComponents:components toDate:date options:0];
    
    return end;
}

+ (NSDate*)previewDate:(NSDate*)date
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:-1];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *end = [gregorian dateByAddingComponents:components toDate:date options:0];
    
    return end;
}

+ (BOOL) compareDate:(NSDate*)date1 Date:(NSDate*)date2
{
    if (([DateChange getYear:date1] == [DateChange getYear:date2]) && ([DateChange getMonth:date1] == [DateChange getMonth:date2]) &&([DateChange getDay:date1] == [DateChange getDay:date2])) {
        return YES;
    }
    return NO;
}
+ (NSString*)parseDate:(NSDate*)date
{
    NSString* text;
    NSString *lang = [[NSUserDefaults standardUserDefaults]stringForKey:@"Language"];
    if ([lang isEqualToString:@"English"]) {
        text = [DateChange getNameDay:date];
        text = [text stringByAppendingString:@", "];
        text = [text stringByAppendingFormat:@"%@ %d", [DateChange getNameMonth:date],[DateChange getDay:date]];
    }
    if ([lang isEqualToString:@"VietNamese"]) {
        text = [DateChange getNameDay:date];
        text = [text stringByAppendingFormat:@", ngày %d %@",[DateChange getDay:date], [DateChange getNameMonth:date]];
    }
    return text;
}
+ (NSString*)parseDateNotNameDate:(NSDate*)date
{
    NSString* text;
    NSString *lang = [[NSUserDefaults standardUserDefaults]stringForKey:@"Language"];
    if ([lang isEqualToString:@"English"]) {
        text = [DateChange getNameDay:date];
        text = [text stringByAppendingString:@", "];
        text = [text stringByAppendingFormat:@"%@ %d", [DateChange getNameMonth:date],[DateChange getDay:date]];
    }
    if ([lang isEqualToString:@"VietNamese"]) {
        text = [NSString stringWithFormat:@"Ngày %d %@",[DateChange getDay:date], [DateChange getNameMonth:date]];
    }
    return text;
}
@end
