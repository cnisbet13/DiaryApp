//
//  DiaryEntry.m
//  CWNDiary
//
//  Created by Calvin Nisbet on 2015-03-26.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

#import "DiaryEntry.h"


@implementation DiaryEntry

@dynamic date;
@dynamic body;
@dynamic imageData;
@dynamic mood;
@dynamic location;

- (NSString *)sectionName {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM yyyy"];
    
    return [dateFormatter stringFromDate:date];
}


@end
