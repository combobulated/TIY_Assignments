//
//  NewFriendViewController.m
//  GitHubFriends
//
//  Created by Jim on 3/18/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "NewFriendViewController.h"

@interface NewFriendViewController ()  <NSURLSessionDataDelegate, UITextFieldDelegate>

{
    UITextField *usernameTextField;
    NSMutableData *receivedData;
    
}
@end

@implementation NewFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   // create a UITextField object
    // with frame
    // located below the nav bar
    
    usernameTextField = [[UITextField alloc] initWithFrame:
                         CGRectMake(10, 74, 300, 40)];  //nav bar is 60 points in height
    //CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
   
    // set the placeholder
    
    usernameTextField.placeholder = @"Username";

   
    // font color
    
    // usernameTextField.textColor = [UIColor whiteColor];
    
    // set the text field background color to white
    
    usernameTextField.backgroundColor = [UIColor whiteColor];
   
     // add the textField view
    // addSubview adds a view to the end of the receiver’s
    // list of subviews.  Is userNameTextField a UIView?
    // its a UITextField, but its a subclass of UIView.
    // addSubview is expectig a UIView, so we are ok.
    
    [self.view addSubview:usernameTextField];
    
//   ------
   
    // add button "Git User"
    
    // use bottom of label field top of "git user" button
    
    CGFloat saveFriendY = usernameTextField.frame.origin.y +
                          usernameTextField.frame.size.height;

    // make button with frame
    
    UIButton *saveFriend = [[UIButton alloc] initWithFrame:
                            CGRectMake(10, saveFriendY, 300, 40)];
    
    
    // set buttons title to "Git User"
    [saveFriend setTitle:@"Git User" forState:UIControlStateNormal];
  
    
    // the buttons action initiates the method "save"
    [saveFriend addTarget:self action:@selector (save) forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:saveFriend];
  
    
   // add button "Cancel"
    
    CGFloat cancelY = saveFriend.frame.origin.y + saveFriend.frame.size.height + 10;
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:
                            CGRectMake(10, cancelY, 300, 40)];
    
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    
    [cancelButton addTarget:self action:@selector (cancel) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:cancelButton];
    
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//#pragma mark - UITextField Delegate

#pragma mark - NSURLSession Delegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler

{    // note completionHandler is a block (varaible that acts like function)
    completionHandler(NSURLSessionResponseAllow);
}

//  assume data is chunky and incomplete... so we park and run multiple times
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data

// park data

{
    if (!receivedData)
    {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }
    else
    {
        [receivedData appendData:data];
    }
}

// task finished, or finished with error, if error, point to NSError object, or no error,
// point to nil
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        // session finished!
        // convert serialized data in receivedData to a foundation object Dictionary, userInfo, and transfer to to
        // array, friends.
        // note: for this log for developer testing only
        
        NSLog(@"Download Successful");
        NSDictionary *userInfo = [ NSJSONSerialization
                                  JSONObjectWithData:receivedData options:0 error:nil];
              
        [self.friends addObject:userInfo];  // friends is a public mutable array defined in header file
       
       // drop the view from the stack
        
        [self cancel];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) save
{
   //Git User Button has been pressed.
    
    // append the user name to the http url to fetch json data from github.
    
    NSString *username = usernameTextField.text;
    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@", username];
   
    NSURL *url = [NSURL URLWithString:urlString];
  
    
    
    /* download data via synchronous web tansfer
     
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // api will return json data in "blob of bits"
   // synchronous request
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
   
    
    // turn the data into usefull format  // json to dictionary
    
    NSDictionary *userInfo = [ NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    

    
    // add data to friends array
    
    [self.friends addObject:userInfo];
  */

    // or download data via asynchronous transfer.. via iOS 7 enhancmentsa
    // but do not save transfer data just yet. We must wait till session is complete.
    // see
    // URLSession:session :)task didCompleteWithError:for handling the data store.
    
    NSURLSessionConfiguration *configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession
                             sessionWithConfiguration:configuration delegate:self
                             delegateQueue:[NSOperationQueue mainQueue ]];

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    [dataTask resume];
   
   // add deleger NSURLSession delegate
    
    //close the moddal view controller NewFriendViewController
  //  [self cancel];  do this later
    
   // [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void) cancel
{
    //close the modal view controller NewFriendViewController
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
