//
//  NewDiaryEntryViewController.h
//  CWNDiary
//
//  Created by Calvin Nisbet on 2015-03-26.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DiaryEntry;

@interface EntryViewController : UIViewController

@property (nonatomic, strong) DiaryEntry *entry;

@end
