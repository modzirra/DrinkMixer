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

- (void)viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"Registering for keyboard events");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    _keyboardIsVisible = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *cancelButton = self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                                          target:self
                                                                                                                          action:@selector(cancel:)];
    
    UIBarButtonItem *saveButton = self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                                                         target:self
                                                                                                                         action:@selector(save:)];
    
    self.navigationItem.rightBarButtonItem = cancelButton;
    self.navigationItem.leftBarButtonItem = saveButton;
    
    _scrollView.contentSize = self.view.frame.size;
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"Unregistering for keyboard events");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Keyboard Handlers
- (void) keyboardDidShow:(NSNotification *)notif
{
    NSLog(@"keyboard did show called");
    self.keyboardIsVisible = YES;
}

- (void) keyboardDidHide:(NSNotification *)notif
{
    NSLog(@"keyboard did hide called");
    self.keyboardIsVisible = NO;
}

#pragma mark - Navigation Toolbar Buttons
- (IBAction) save:(id)sender
{
    NSLog(@"Save pressed!");
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) cancel:(id)sender
{
    NSLog(@"Cancel pressed!");
    [self.navigationController popViewControllerAnimated:YES];
}
@end
