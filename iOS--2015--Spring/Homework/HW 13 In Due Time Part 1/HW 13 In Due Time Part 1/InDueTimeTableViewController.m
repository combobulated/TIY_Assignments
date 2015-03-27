//
//  InDueTimeTableViewController.m
//  HW 13 In Due Time Part 1
//
//  Created by Jim on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "InDueTimeTableViewController.h"
#import "TodoItem.h"



@interface InDueTimeTableViewController () <UITextFieldDelegate>

{
   // instance variables
   
    NSMutableArray *taskList;
    
}

- (IBAction)addTodoItem:(UIBarButtonItem *)sender;


@end



@implementation InDueTimeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    taskList = [[NSMutableArray alloc] init];
    
    self.title = @"In Due Time";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView
                      :(UITableView *)tableView numberOfRowsInSection
                      :(NSInteger)section
{
    // Return the number of rows in the section.
    return [taskList count];
}

- (UITableViewCell *)tableView
                               :(UITableView *)tableView cellForRowAtIndexPath
                               :(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoItemCell" forIndexPath:indexPath];
    
    // Configure the cell...
    // Configure the cell...
    
    TodoItem *item = taskList[indexPath.row]; // each item in our task list
    // has a)task and b) eventually a date
    
    
    UITextField *textField = (UITextField *)[cell viewWithTag:1];  //task text field
    
    // this class is assigned as delegate for the textField
    
//    textField.delegate = self;
   
    textField.text = @"";
    
    if (item)
    {
        if(!(item.taskName == @""))
        {
            [textField setText:item.taskName];    // display the task
        }
        else
        {   // textfield is empty
            // lets add focus to text field and bring keyboard
            
            [textField becomeFirstResponder];
        }
        
    }
    
    return cell;
}

// Override to support conditional editing of the table view.

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        // Delete the row from the data source
        
        [ taskList removeObjectAtIndex:indexPath.row ];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert)
//    {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UITextField delegate

- ( BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // user has typed in a task in the label field.
    // add this task to the TaskList array.
    
    BOOL rc = NO;
    
    if ( ![textField.text isEqualToString:@""])
    {
        [textField resignFirstResponder];   // close keyboard
        
        // store the task to the taskList array
        // but what cell are we storing?
        
        
        // what view are we in
        UIView *contentView = [textField superview]; // returns VIEW
        
        // well cell
        UITableViewCell *cell = (UITableViewCell *) [contentView superview]; //return CELL we are in
        
        NSIndexPath *path = [self.tableView indexPathForCell:cell]; // location of cell
        
        
        
        // we now know the cell, lets populate the taskList, a mutable
        // object array
        
        
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

