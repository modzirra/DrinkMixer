//
//  WDAddDrinkViewController.m
//  DrinkMixer
//
//  Created by Aimee on 11/9/13.
//  Copyright (c) 2013 Web Diggity. All rights reserved.
//

#import "WDAddDrinkViewController.h"

@interface WDAddDrinkViewController ()

@end

@implementation WDAddDrinkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    //not working
    UIBarButtonItem *cancelButton = self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancel:)];
    
    UIBarButtonItem *saveButton = self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(save:)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) save:(id)sender
{
    NSLog(@"Save pressed!");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) cancel:(id)sender
{
    NSLog(@"Cancel pressed!");
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
