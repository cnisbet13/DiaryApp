//
//  EntryCell.m
//  CWNDiary
//
//  Created by Calvin Nisbet on 2015-04-16.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

#import "EntryCell.h"
#import "DiaryEntry.h"

@implementation EntryCell


 + (CGFloat)heightForEntry:(DiaryEntry *)entry
{
    const CGFloat topMargin = 35.0f;
    const CGFloat bottomMargin = 39.0f;
    const CGFloat minHeight = 85.0f;
    
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGRect boundingBox = [entry.body boundingRectWithSize:CGSizeMake(202, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:nil];
    
    return MAX(minHeight, CGRectGetHeight(boundingBox) + topMargin + bottomMargin);
}


@end
