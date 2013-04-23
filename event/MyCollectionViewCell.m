//
//  MyCollectionViewCell.m
//  event
//
//  Created by Hemanth Prasad on 22/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
     self.label.text=self.event.name;
    // Drawing code
}


@end
