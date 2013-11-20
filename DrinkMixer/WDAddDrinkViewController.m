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
    //check to see if keyboard is already up
    if (_keyboardIsVisible == YES)
    {
        NSLog(@"%@", @"Keyboard is already visible.  Ignoring notification.");
        return;
    }
    //the keyboard wasn't visible before
    NSLog(@"Resizing smaller for keyboard");
    
    //get the origin of the keyboard when it finishes animating.
    NSDictionary *info = [notif userInfo];
    
    //get the keyboard size from the NSDict
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    //Get the top of the keyboard in view's coordinate system.
    //set the bottom of the scroll view to line up with the top of the keyboard.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGFloat keyboardTop = keyboardRect.origin.y;
    
    //Resize the scroll view to make room for the keyboard
    CGRect viewFrame = self.view.bounds;
    viewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    self.scrollView.frame = viewFrame;
    
    _keyboardIsVisible = YES;
}

- (void) keyboardDidHide:(NSNotification *)notif
{
    //The keyboard was visible
    if (!_keyboardIsVisible)
    {
        NSLog(@"%@", @"Keyboard already hidden.  Ignoring notification.");
        return;
    }
    //Resize the scroll view back to the full size of the view
    NSLog(@"%@", @"Resizing bigger with no keyboard");
    self.scrollView.frame = self.view.bounds;
    _keyboardIsVisible = NO;
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
