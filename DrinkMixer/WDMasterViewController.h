//
//  WDMasterViewController.h
//  DrinkMixer
//
//  Created by Aimee on 11/8/13.
//  Copyright (c) 2013 Web Diggity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDMasterViewController : UITableViewController
{
    NSMutableArray *_drinks;
}

@property (nonatomic, strong) NSMutableArray* drinks;

@end
