//
//  FolderMainViewController.m
//  FootingCalculatorPro
//
//  Created by lichuncheng on 12/16/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import "FolderMainViewController.h"

@interface FolderMainViewController ()

@end

@implementation FolderMainViewController

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"headerimage.png"] forBarMetrics:UIBarMetricsDefault];
}
-(void)viewDidAppear:(BOOL)animated
{
    /*
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs stringForKey:@"preference"] == nil || [[prefs stringForKey:@"preference"] intValue] == 0)
    {
        _quotations.hidden = YES;
    }
    else
        _quotations.hidden = NO;
     */
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
