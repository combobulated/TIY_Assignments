//
//  TodoTableViewController.m
//  Todo
//
//  Created by Jim on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TodoTableViewController.h"
#import "PriorityTableViewController.h"

#import "TodoItem.h"


// note we add delegate for both textfield input and popoverpresentation

@interface TodoTableViewController ()  <UITextFieldDelegate,          UIPopoverPresentationControllerDelegate>


     // our variables
{
    // task list items
    NSMutableArray *taskList;
}


- (IBAction)addTodoItem:(UIBarButtonItem *)sender;

@end

@implementation TodoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initialize taskList
    
    taskList = [[NSMutableArray alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
//    return 0;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    
    // use our taskList array to determine number of rows
    return [taskList count];
}


// populate a single cell of our Todo table view.
//  table view has a:    taskTEXT FIELD      priorityLABEL    ModifyBUTTON
//  1) text field that displays and allow user to enter/alter a task with a keyboard
//  2) a label field that displays the tasks priority
//  3) a modify button that seques to a popup window containing selections for choices of
//     priority ie High, Medium or Low
//  4) A bar "+" button to add a new task.
//  The main todo table will show a columnar list of todos with an associated priority
//   ie.. take out trash   Low
//        wash car         Low
//        study homework   High

- (UITableViewCell *)tableView
                               :(UITableView *)tableView cellForRowAtIndexPath
                               :(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    
    // Configure the cell...a
    
    TodoItem *item = taskList[indexPath.row]; // one item in our task list
                                              // item has a) task and b) a priority
    
    
    UITextField *textField = (UITextField *)[cell viewWithTag:1];  //task text field
    UILabel *priorityLabel = (UILabel *) [cell viewWithTag:2];     //priority text field
  
    textField.delegate = self;
    
    if (item)
    {
       if(item.taskName)
       {
           [textField setText:item.taskName];          // display the task
       }
       else
       {   // textfield is empty
           // lets add focus to text field and bring keyboard
           
           [textField becomeFirstResponder];
       }
    
       priorityLabel.text = [item priorityAsString];   //display the priority
    
    }

    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
   //which segue?
    if ([segue.identifier isEqualToString:@"ShowPriorityPopoverSeque"])
    {
        PriorityTableViewController *destVC = (PriorityTableViewController *) [segue destinationViewController];
        
        destVC.popoverPresentationController.delegate = self;
       
        NSArray *priorityTypes = [TodoItem allPriorityTypes];
        
        // note standard cell height is 44points
        // we are setting contentHeight to a value that will fit
        // the number of priority types.
        
        float contentHeight = 44.0f * [priorityTypes count];
        destVC.preferredContentSize = CGSizeMake(100.0f, contentHeight);
    }
    
    
    
}

#pragma mark -PopoverPresentationController delegate

// here, i believe, we would populate the priority value in the TaskList

//jim add missing code here...
//{
//return VIModalPresentationNone;
//}


#pragma mark - UITextField delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    // user has typed in a task in the label field.
    // add this task to the TaskList array.
    
    BOOL rc = NO;
    
    if ( ![textField.text isEqualToString:@""])
    {
        [textField resignFirstResponder];   // close keyboard
        
        // store the task to the taskList array
        // but what cell are we storing?
        
        UIView *contentView = [textField superview];                    // returns VIEW we are in
        UITableViewCell *cell = (UITableViewCell *) [contentView superview]; //return CELL we are in
        NSIndexPath *path = [self.tableView indexPathForCell:cell]; // location of cell
      
        
        
        // we now know the cell, lets populate the taskList mutable object array
       
        
        // first grab a handle to the taskList array
        
        TodoItem *anItem = taskList[path.row];
      
        
        // populate taskList with the task entered in the text field
        
        anItem.taskName = textField.text;
        
        
        rc = YES;
    }
    return rc;
}

#pragma mark - Action Handlers

// the Plus button has been tapped.  Lets make a new cell
// and allow user to add a new task.

- (IBAction)addTodoItem:(UIBarButtonItem *)sender
{
    // make space for a todo item in the taskList array
    
    TodoItem *anItem = [[TodoItem alloc]init];
    [taskList addObject:anItem];
   
    
    //repaint the table
    
    [self.tableView reloadData];
    
}

@end
