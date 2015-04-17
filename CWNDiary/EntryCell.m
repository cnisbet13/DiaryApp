//
//  EntryCell.m
//  CWNDiary
//
//  Created by Calvin Nisbet on 2015-04-16.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

#import "EntryCell.h"
#import "DiaryEntry.h"


@interface EntryCell ()
//Private IBOutlets
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (weak, nonatomic) IBOutlet UIImageView *moodImageView;

@end

@implementation EntryCell


 + (CGFloat)heightForEntry:(DiaryEntry *)entry
{
    const CGFloat topMargin = 35.0f;
    const CGFloat bottomMargin = 80.0f;
    const CGFloat minHeight = 106.0f;
    
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGRect boundingBox = [entry.body boundingRectWithSize:CGSizeMake(202, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:nil];
    
    return MAX(minHeight, CGRectGetHeight(boundingBox) + topMargin + bottomMargin);
}

- (void)configureCellForEntry:(DiaryEntry *)entry
{
    self.bodyLabel.text = entry.body;
    self.locationLabel.text = entry.location;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMMM d yyyy"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:entry.date];
    self.dateLabel.text = [dateFormatter stringFromDate:date];
    
    if (entry.imageData) {
        self.mainImageView.image = [UIImage imageWithData:entry.imageData];
    } else {
        self.mainImageView.image = [UIImage imageNamed:@"icn_noimage"];
    }   
    if (entry.mood == DiaryEntryMoodGood) {
        self.moodImageView.image = [UIImage imageNamed:@"icn_happy"];
    } else if (entry.mood == DiaryEntryMoodAverage) {
        self.moodImageView.image = [UIImage imageNamed:@"icn_average"];
    } else if (entry.mood == DiaryEntryMoodBad) {
        self.moodImageView.image = [UIImage imageNamed:@"icn_bad"];
    }
}














@end
