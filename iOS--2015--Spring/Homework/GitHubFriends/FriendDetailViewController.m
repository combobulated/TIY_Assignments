//
//  FriendDetailViewController.m
//  GitHubFriends
//
//  Created by Jim on 3/18/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "FriendDetailViewController.h"

@interface FriendDetailViewController () <NSURLSessionDataDelegate, UITableViewDataSource, UITableViewDelegate >

{
    NSArray *repos;  // array of dictionarys
    UILabel *locationLabel;
    UILabel *emailLabel;
    NSMutableData *receivedData;  //data park
    UITableView *theRepoTableView;
}

@end

@implementation FriendDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    // Fetch the "login" attribute from the friendInfo dictionary and sto
    // re it in a local variable.
    
 
    // friends
    
    NSString *userName = [self.friendInfo objectForKey:@"login"];
  
  //yep, login reports user name!
  //NSLog(@"login = %@",userName);
 
//  next step:
//  Create a url string variable that uses the following: "https://api.github.com/users/?/repos" where ? is replaced with the username of the Github user.

    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", userName];
   
    NSLog(@"user url = %@", urlString);
  
    // next 2 steps
    
    // Convert the url string created above into an NSURL object.
    NSURL *url = [NSURL URLWithString:urlString];
   /*
    // Create an NSURLRequest object with the NSURL above.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
   
    
    // sync procedure to download json data from API of  a remote website.
    
    // Run a synchronous request with the request above and save
    // the response in an NSData object.
    
    // api will return json data in "blob of bits"
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
   
    //  Convert the NSData object above into a native object (hint, you created a private instance variable to store this).
    
    //  turn the data into usefull format  // json to dictionary
    
    // mark1
    
    repos = [ NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    
    
    // [ ] Print the contents of the native object above to the console.
    
    NSLog(@"return response to repos request = %@ ", repos ) ;
   */
   
    
    // async procedure... the prefered method to download json data
    
    NSURLSessionConfiguration *configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession
                             sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
   
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    [dataTask resume];
    
    // create table view here: (UITableView
    
    
    
   //  Create two UILabel objects and place them on the screen with a frame. The first one should be in the upper left corner and the second one should be left aligned with the first and just below it with a small amount of padding.
 
    
   // create a UILabel object
    // with frame
    // located below the nav bar
    
    locationLabel = [[UILabel alloc] initWithFrame:
                         CGRectMake(10, 74, 300, 40)];  //nav bar is 60 points in height
    //CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
   
    // font color
    
    // usernameTextField.textColor = [UIColor whiteColor];
    
    // set the label field background color to white
    
   locationLabel.backgroundColor = [UIColor whiteColor];
    
    
    // set the label text to location
    
    NSString *userLocation = [self.friendInfo objectForKey:@"location"];
    locationLabel.text = userLocation;
    
   
     // add the label field view
    // addSubview adds a view to the end of the receiver’s
    // list of subviews.  Is locationLabel a UIView?
    // its a UITextField, but its a subclass of UIView.
    // addSubview is expectig a UIView, so we are ok.
    
    [self.view addSubview:locationLabel];
   //-----
 
    // add label for the email text string
    
    emailLabel = [[UILabel alloc] initWithFrame:
                         CGRectMake(10, 74+40+10, 300, 40)];  //nav bar is 60 points in height
    //CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
   
    // font color
    
    // usernameTextField.textColor = [UIColor whiteColor];
    
    // set the label field background color to white
    
     emailLabel.backgroundColor = [UIColor whiteColor];
    
    // set the label text to location
    
    NSString *userEmail = [self.friendInfo objectForKey:@"email"];
    emailLabel.text = userEmail;
    
   
     // add the label field view
    // addSubview adds a view to the end of the receiver’s
    // list of subviews.  Is locationLabel a UIView?
    // its a UITextField, but its a subclass of UIView.
    // addSubview is expectig a UIView, so we are ok.
    
    [self.view addSubview:emailLabel];
   //
    
    
   // create a view just below the labels
    
   //  Create a UITableView object and set its frame to be just
   // below the second label from above. It should be the same width as the view and should extend to the bottom of the view.
  
        /* sample  with jims first attempt mods
         
        NSDictionary *aFriend = friends[indexPath.row];
        
        
        //create new repos table view controller
        
        ReposTableViewController * reposVC = [[ReposTablelViewController alloc]initWithFrame:
                         CGRectMake(10, 74+40+20, 300, 300)];  //nav bar is 60 points in height
    //CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        
        
        // pass a pointer to the friends array to the new view
        
        reposVC.reposInfo = aFriend;
        
        
        //set color of background
        
        friendsDetailVC.view.backgroundColor = [UIColor whiteColor];
        
        
        // We have an instance of this new view controller
        // Push it onto the navigation stack when a FriendCell is tapped.
        // Take view controller just created and place on view stack.
        
        [self.navigationController pushViewController:reposVC animated:YES ];
       */
        
        //mark detail table
       theRepoTableView = [[UITableView alloc] initWithFrame:
                         CGRectMake(0, 180, self.view.frame.size.width, self.view.frame.size.height - 144)];  //nav bar is 60 points in height
       //CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
   
       // define / register cell class with table view
       [theRepoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
        theRepoTableView.delegate = self;
        theRepoTableView.dataSource = self;
    
        [self.view addSubview:theRepoTableView];
        
}
        
# pragma mark - table dataSource delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [repos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *repo = repos[indexPath.row];
    
    cell.textLabel.text = repo[@"name"];
    
    if (repo[@"description"] != [NSNull null])
    {
        cell.detailTextLabel.text = repo[@"description"];
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSURLSessionData delegate

- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler

{
    completionHandler(NSURLSessionResponseAllow);
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if (!receivedData) {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }
    else{
        [receivedData appendData:data];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error) {
        NSLog(@"Download successful.");
        repos = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
    
        // populate table view...
        [theRepoTableView reloadData];
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
