//
//  MyCollectionViewCell.h
//  event
//
//  Created by Hemanth Prasad on 22/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
@interface MyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak,nonatomic) Event* event;
@end
