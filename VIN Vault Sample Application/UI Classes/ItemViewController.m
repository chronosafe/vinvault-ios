//
//  ItemViewController.m
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/14/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import "ItemViewController.h"
#import "Vehicle.h"
#import "Vehicle+Sectioned.h"
#import "OptionViewController.h"

@interface ItemViewController ()
{
    NSEnumerator *keys;
}
@end

@implementation ItemViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[_vehicle groupNames] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [[_vehicle itemsForGroup:[[_vehicle groupNames] objectAtIndex:section]] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[_vehicle groupNames] objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *section = [_vehicle itemsForGroup:[[_vehicle groupNames] objectAtIndex:indexPath.section]];
    Item *item = [section objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = item.value;
    cell.textLabel.text = item.category;
    if ([item.options count] > 0)
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    Item *item = [self itemAtIndexPath:[self.tableView indexPathForSelectedRow]];
    return ([item.options count] > 0);
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    OptionViewController *optionController = (OptionViewController *)[segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Item *item = [self itemAtIndexPath:indexPath];
    optionController.item = item;
}

-(Item *)itemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *section = [_vehicle itemsForGroup:[[_vehicle groupNames] objectAtIndex:indexPath.section]];
    Item *item = [section objectAtIndex:indexPath.row];
    return item;
}


@end
