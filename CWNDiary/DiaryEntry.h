//
//  DiaryEntry.h
//  CWNDiary
//
//  Created by Calvin Nisbet on 2015-03-26.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

//Setting Constants instead of numbers
NS_ENUM(int16_t, DiaryEntryMood)
{
    DiaryEntryMoodGood = 0,
    DiaryEntryMoodAverage = 1,
    DiaryEntryMoodBad = 2
};


@interface DiaryEntry : NSManagedObject



@property (nonatomic) NSTimeInterval date;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic) int16_t mood;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, readonly) NSString *sectionName;


@end
