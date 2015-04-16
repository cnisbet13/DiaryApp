//
//  EntryCell.h
//  CWNDiary
//
//  Created by Calvin Nisbet on 2015-04-16.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DiaryEntry;

@interface EntryCell : UITableViewCell


+ (CGFloat)heightForEntry:(DiaryEntry *)entry;

@end
