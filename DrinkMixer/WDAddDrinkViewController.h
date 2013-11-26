//
//  WDAddDrinkViewController.h
//  DrinkMixer
//
//  Created by Aimee on 11/9/13.
//  Copyright (c) 2013 Web Diggity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDDetailViewController.h"

@interface WDAddDrinkViewController : WDDetailViewController

- (IBAction) save:(id)sender;
- (IBAction) cancel:(id)sender;
- (void) keyboardDidShow:(NSNotification *) notif;
- (void) keyboardDidHide:(NSNotification *) notif;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property BOOL keyboardIsVisible;
@property (nonatomic, strong) NSMutableArray *drinks;
@property (nonatomic, strong) NSMutableDictionary *drink;

@end
