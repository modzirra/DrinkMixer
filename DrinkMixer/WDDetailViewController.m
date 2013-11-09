//
//  WDDetailViewController.m
//  DrinkMixer
//
//  Created by Aimee on 11/8/13.
//  Copyright (c) 2013 Web Diggity. All rights reserved.
//

#import "WDDetailViewController.h"
#import "DrinkConstants.h"

@interface WDDetailViewController ()
- (void)configureView;
@end

@implementation WDDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    //Set up UI with selected drink
    self.nameTextField.text = [self.drink objectForKey:NAME_KEY];
    self.ingredientsTextView.text = [self.drink objectForKey:INGREDIENTS_KEY];
    self.directionsTextView.text = [self.drink objectForKey:DIRECTIONS_KEY];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


@end
