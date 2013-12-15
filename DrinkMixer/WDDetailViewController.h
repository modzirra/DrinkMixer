//
//  WDDetailViewController.h
//  DrinkMixer
//
//  Created by Aimee on 11/8/13.
//  Copyright (c) 2013 Web Diggity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrinkConstants.h"
#import "Drink.h"

@interface WDDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (nonatomic, strong) IBOutlet UITextView *ingredientsTextView;
@property (nonatomic, strong) IBOutlet UITextView *directionsTextView;
@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) Drink *drink;
@property (nonatomic, strong) NSMutableArray *drinks;

@end