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
    UIBarButtonItem *addButton_;
}

@property (nonatomic, strong) NSMutableArray *drinks;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *addButton;

-(IBAction) addButtonPressed: (id)sender;

@end
