//
//  WDMasterViewController.m
//  DrinkMixer
//
//  Created by Aimee on 11/8/13.
//  Copyright (c) 2013 Web Diggity. All rights reserved.
//

#import "WDMasterViewController.h"
#import "WDDetailViewController.h"
#import "WDAddDrinkViewController.h"
#import "DrinkConstants.h"

@interface WDMasterViewController ()
{
    //NSMutableArray *_objects;
    NSMutableArray *_drinks;
    UIBarButtonItem *_addButton;
}

@end

@implementation WDMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    //path to plist array
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DrinkDirections" ofType:@"plist"];
    //load array from plist using path
    _drinks = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    //add background notifier for saving to disk
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - Actions
- (void)addButtonPressed:(id)sender
{
    if (!self.drinks)
    {
        self.drinks = [[NSMutableArray alloc] init];
    }
    NSDictionary *drink = [[NSDictionary alloc] initWithObjectsAndKeys:@"",@"directions",@"",@"name",@"",@"ingredients", nil];
    [self.drinks insertObject:drink atIndex:self.drinks.count];
    
    [self performSegueWithIdentifier:(@"addItem") sender:self];
}

- (void) applicationDidEnterBackground: (NSNotification *)notification
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DrinkDirections" ofType:@"plist"];
    NSLog(@"Saving");
    [self.drinks writeToFile:path atomically:YES];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.drinks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //make an empty cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //set cell text
    cell.textLabel.text = [[self.drinks objectAtIndex:indexPath.row] objectForKey:NAME_KEY];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.drinks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSDictionary *pickedDrink = _drinks[indexPath.row];
        [[segue destinationViewController] setDetailItem:pickedDrink];
        [[segue destinationViewController] setDrink:[_drinks objectAtIndex:indexPath.row]];
    }
    if ([[segue identifier] isEqualToString:@"addItem"])
    {
        [[segue destinationViewController] setDrinks:self.drinks];
    }
  }

@end