//
//  GuidesDetailViewController.m
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import "GuidesDetailViewController.h"

@interface GuidesDetailViewController ()

@end

@implementation GuidesDetailViewController

@synthesize index;

- (void)viewDidLoad {
    [super viewDidLoad];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        //return YES; /* Device is iPad */
        //[self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"headerimage.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forBarMetrics:UIBarMetricsDefault];
        //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"headerimage.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headerimage.png"]];
        
    }
    else{
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headerimage.png"]];
        //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"headerimage.png"] forBarMetrics:UIBarMetricsDefault];
    }
    // Do any additional setup after loading the view.
    
    NSString	 * nsstrPath;
    switch (index) {
        case 0:
            nsstrPath = [ [ NSBundle mainBundle ] pathForResource : @"guide_how_to_lay_pavers" ofType : @"html" ] ;
            break;
        case 1:
            nsstrPath = [ [ NSBundle mainBundle ] pathForResource : @"how_to_use_this_app" ofType : @"html" ] ;
            break;
        case 2:
            nsstrPath = [ [ NSBundle mainBundle ] pathForResource : @"safety_for_laying_pavers" ofType : @"html" ] ;
            break;
        case 3:
            nsstrPath = [ [ NSBundle mainBundle ] pathForResource : @"tools_for_laying_pavers" ofType : @"html" ] ;
            break;
    }
    
    NSURL	 * nsURL = [ NSURL fileURLWithPath : nsstrPath ] ;
    NSURLRequest	 * nsURLRequest = [ NSURLRequest requestWithURL : nsURL ] ;
    [_webview loadRequest : nsURLRequest ] ;
    _webview.backgroundColor = [UIColor blackColor];
    _webview.opaque = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
