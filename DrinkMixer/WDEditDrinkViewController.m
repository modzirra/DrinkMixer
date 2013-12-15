//
//  WDEditDrinkViewController.m
//  DrinkMixer
//
//  Created by Aimee on 12/14/13.
//  Copyright (c) 2013 Web Diggity. All rights reserved.
//

#import "WDEditDrinkViewController.h"

@interface WDEditDrinkViewController ()

@end

@implementation WDEditDrinkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)configureView
{
    // Update the user interface for the detail item.
    //Set up UI with selected drink
    self.nameTextField.text = self.drink.nameTextField;
    self.ingredientsTextView.text = self.drink.ingredientsTextView;
    self.directionsTextView.text = self.drink.directionsTextView;
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
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    _scrollView.contentSize = self.view.frame.size;
}

- (void)viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:animated];
    
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

- (void)viewDidDisappear:(BOOL)animated
{
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
    self.scrollView.frame = self.view.bounds;
    _keyboardIsVisible = NO;
}

#pragma mark - Navigation Toolbar Buttons
- (IBAction) save:(id)sender
{
    NSLog(@"save pressed!");
    //TODO: need to remove this drink from drinks array
    //get index of this drink
    NSUInteger drinkIndex = [self.drinks indexOfObject:self.drink];
    [NSString stringWithFormat:@"%d", drinkIndex];
    
    //remove this drink from drinks
    NSString *item = [self.drinks objectAtIndex:drinkIndex];
    [self.drinks removeObject:item];
    
    //create temporary dict
    NSMutableDictionary *editedDrink = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value1", @"ingredients", @"value2", @"name", @"value3", @"directions", nil];
    
    //get info from fields and assign to the new drink property
    [editedDrink setObject:self.ingredientsTextView.text forKey:@"ingredients"];
    [editedDrink setObject:self.nameTextField.text forKey:@"name"];
    [editedDrink setObject:self.directionsTextView.text forKey:@"directions"];
    
    NSString *drinkName = [editedDrink objectForKey:@"name"];
    
    NSLog(@"edited drink is %@", drinkName);
    
    //add new dict to drinks array
    [self.drinks addObject:editedDrink];
    
    //sort drinks with new item by alpha
    NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = @[nameSorter];
    NSArray *sortedArray = [self.drinks sortedArrayUsingDescriptors:sortDescriptors];
    
    //empty old drinks array
    [super.drinks removeAllObjects];
    
    //update the drinks list on detail view
    [super.drinks addObjectsFromArray:sortedArray];

    //update drink to edited drink on detail view
    id sobj = super.drink.nameTextField;
        // Do something with them
        NSLog(@"super drink is %@", sobj);
    
    //save new plist data to custom plist in documents directory
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [NSString stringWithFormat:@"%@/drinks.plist", documents];
    [sortedArray writeToFile:filePath atomically:YES];
    
    //dismiss pushed view
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) cancel:(id)sender
{
    NSLog(@"cancel pressed!");
    //remove placeholder drink
    [self.drinks removeLastObject];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
