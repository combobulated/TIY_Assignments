//
//  ViewController.m
//  CoreList
//
//  Created by Jim on 3/31/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"
#import "ListItemTableViewController.h"
#import "CoreDataStack.h"
#import "Listitem.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *taskItemTextField;

//@property (weak, nonatomic) IBOutlet UIButton *saveButton;
//@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

- (IBAction)saveButton:(UIButton *)sender;
- (IBAction)cancelButton:(UIButton *)sender;

@end

@implementation ViewController // <UITextFieldDelegate>

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Handlers

- (IBAction)saveButton:(UIButton *)sender
{
   
    //  store the text in the texfield into our model object
    
    Listitem *aItem = [NSEntityDescription insertNewObjectForEntityForName:@"Listitem" inManagedObjectContext:self.cdStack.managedObjectContext];  // model object aItem retrieved from core data stack.
    
    aItem.item = self.taskItemTextField.text;  // store the text
   
//        [listitems addObject:aItem]; // no longer necessary being item is now stored in the core data stack
//        NSInteger index = [listitems indexOfObject:aItem];
    
    

    if (![self.taskItemTextField.text isEqualToString:@"" ])
    
        {
//            [self saveCoreDataUpdates];
            [self.taskItemTextField resignFirstResponder];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    
    
    
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


- (IBAction)cancelButton:(UIButton *)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Core Data


- (void) saveCoreDataUpdates
{
    [self.cdStack saveOrFail:^(NSError *errorOrNil)
     {
         if (errorOrNil)
         {
             NSLog(@"Error from CDStack: %@", [errorOrNil localizedDescription]);
         }
     }];
}

@end
