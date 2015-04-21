//
//  ListitemTableViewController.m
//  CoreList
//
//  Created by Jim on 3/31/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//


#import "CoreDataStack.h"
#import "ListitemTableViewController.h"
#import "ViewController.h"
#import "Listitem.h"


@interface ListitemTableViewController ()

{
     NSMutableArray *listitems;
     CoreDataStack  *cdStack;
}

//  handeled by the segue
//- (IBAction)addNewListitem:(UIBarButtonItem *)sender;


@end


@implementation ListitemTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 
    
    // pass model name to coreDataStack
    
    cdStack = [CoreDataStack coreDataStackWithModelName:@"CoreListModel"];
   
    
    // set coreDataStore type to SQL
    
    cdStack.coreDataStoreType = CDSStoreTypeSQL;
  
   
    
    // items stored in our list item array
    
    listitems = [[NSMutableArray alloc] init];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // will appear regularly updates the view as opposed to viewDidLoad which only updates view once.
    // for this reason, we add the coredata fetch request to retrieve our Listitem model data.

    NSEntityDescription *entity = [ NSEntityDescription entityForName:@"Listitem" inManagedObjectContext:cdStack.managedObjectContext ];
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    
    fetch.entity = entity;
    
    listitems  = nil;
    
    listitems = [[cdStack.managedObjectContext executeFetchRequest:fetch error:nil] mutableCopy];
 
    [self.tableView reloadData];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listitems count] ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListitemCell" forIndexPath:indexPath];
  
    Listitem *aListitem = listitems[indexPath.row];
    
    [cell.textLabel  setText:aListitem.item];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// this needs work ...this needs work
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
   // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Action Handlers

//- (IBAction)addNewListitem:(UIBarButtonItem *)sender
//{
//    
//    Student *aStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:cdStack.managedObjectContext];
//    [students addObject:aStudent];
//    NSInteger index = [students indexOfObject:aStudent];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
   
    if ([segue.identifier isEqualToString:@"ViewControllerSegue"])
        
    {
        ViewController *modelVC = (ViewController *)[segue destinationViewController];
        modelVC.cdStack = cdStack;
    }
    
}

@end
