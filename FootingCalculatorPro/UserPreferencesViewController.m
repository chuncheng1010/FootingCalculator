//
//  UserPreferencesViewController.m
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import "UserPreferencesViewController.h"

@interface UserPreferencesViewController ()

@end

@implementation UserPreferencesViewController

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

-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs stringForKey:@"method"] == nil || [[prefs stringForKey:@"method"] intValue] == 0)
    {
        
        methodindex = 0;
    }
    else
    {
        methodindex = [[prefs stringForKey:@"method"] intValue];
        
    }
    [self measurementsDisplay:methodindex];
    
    if([prefs stringForKey:@"type"] == nil || [[prefs stringForKey:@"type"] intValue] == 0)
        typeindex = 0;
    
    else
        typeindex = [[prefs stringForKey:@"type"] intValue];
    [self concreteTypeDisplay:typeindex];
    
    if([prefs stringForKey:@"strength"] == nil || [[prefs stringForKey:@"strength"] intValue] == 0)
        strengthindex = 0;
    else
        strengthindex = [[prefs stringForKey:@"strength"] intValue];
    [self stringthDisplay:strengthindex];
    
    if([prefs stringForKey:@"currency"] == nil || [[prefs stringForKey:@"currency"] intValue] == 0)
        currencyindex = 0;
    else
        currencyindex = [[prefs stringForKey:@"currency"] intValue];
    [self currencyDisplay:currencyindex];
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

- (IBAction)savePreferences:(id)sender {
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Would you like to save these settings?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [view show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"%d",_typeselect.selectedSegmentIndex);
    if(buttonIndex == 0)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:[NSString stringWithFormat:@"%d",methodindex] forKey:@"method"];
        [prefs setObject:[NSString stringWithFormat:@"%d",typeindex]  forKey:@"type"];
        [prefs setObject:[NSString stringWithFormat:@"%d",strengthindex]  forKey:@"strength"];
        [prefs setObject:[NSString stringWithFormat:@"%d",currencyindex]  forKey:@"currency"];
        
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [view show];
        
    }
    //[self.navigationController popViewControllerAnimated:YES];
}

-(void)measurementsDisplay:(int)value
{
    switch (value) {
        case 0:
            [_methodbtn setTitle:@"Metric(Metres * Millmetres)" forState:UIControlStateNormal];
            break;
        case 1:
            [_methodbtn setTitle:@"Imperial(Feet & Inches)" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    methodindex = value;
}
- (IBAction)measurementSelect:(id)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Select"
                                                                        message:@"Preference - Measurement"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action) {
                                                            //NSLog(@"Dismiss button tapped!");
                                                        }];
    
    [controller addAction:alertAction];
    
    UIAlertAction *first = [UIAlertAction actionWithTitle:@"Metric(Metres * Millmetres)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self measurementsDisplay:0];
    }];
    [controller addAction:first];
    
    UIAlertAction *second = [UIAlertAction actionWithTitle:@"Imperial(Feet & Inches)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self measurementsDisplay:1];
    }];
    [controller addAction:second];
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (IBAction)concreteSelect:(id)sender {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Select"
                                                                        message:@"Concrete Type"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action) {
                                                            //NSLog(@"Dismiss button tapped!");
                                                        }];
    
    [controller addAction:alertAction];
    
    UIAlertAction *first = [UIAlertAction actionWithTitle:@"Piers" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self concreteTypeDisplay:0];
    }];
    [controller addAction:first];
    
    UIAlertAction *second = [UIAlertAction actionWithTitle:@"Pads" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self concreteTypeDisplay:1];
    }];
    [controller addAction:second];
    
    UIAlertAction *third = [UIAlertAction actionWithTitle:@"Strip Footings" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self concreteTypeDisplay:2];
    }];
    [controller addAction:third];
    
    
    
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)concreteTypeDisplay:(int)value
{
    switch(value)
    {
        case 0:
            [_typebtn setTitle:@"Piers" forState:UIControlStateNormal];
            break;
        case 1:
            [_typebtn setTitle:@"Pads" forState:UIControlStateNormal];
            break;
        case 2:
            [_typebtn setTitle:@"Strip Footings" forState:UIControlStateNormal];
            break;
        default:
            break;
        
    }
    typeindex = value;
}

-(void)stringthDisplay:(int)value
{
    switch (value) {
        case 0:
            [_strengthbtn setTitle:@"Concrete - 20Mpa" forState:UIControlStateNormal];
            break;
        case 1:
            [_strengthbtn setTitle:@"Concrete - 25Mpa" forState:UIControlStateNormal];
            break;
        case 2:
            [_strengthbtn setTitle:@"Concrete - 32Mpa" forState:UIControlStateNormal];
            break;
        case 3:
            [_strengthbtn setTitle:@"Concrete - 40Mpa" forState:UIControlStateNormal];
            break;
        case 4:
            [_strengthbtn setTitle:@"Concrete - 50Mpa" forState:UIControlStateNormal];
            break;
        case 5:
            [_strengthbtn setTitle:@"Concrete - 60Mpa" forState:UIControlStateNormal];
            break;
        case 6:
            [_strengthbtn setTitle:@"Concrete - 65Mpa" forState:UIControlStateNormal];
            break;
        case 7:
            [_strengthbtn setTitle:@"Concrete - 80Mpa" forState:UIControlStateNormal];
            break;
        case 8:
            [_strengthbtn setTitle:@"Concrete - 100Mpa" forState:UIControlStateNormal];
            break;
        
        default:
            break;
    }
    strengthindex = value;
}
- (IBAction)strengthSelect:(id)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Select"
                                                                        message:@"Concrete Strength"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action) {
                                                            //NSLog(@"Dismiss button tapped!");
                                                        }];
    
    [controller addAction:alertAction];
    
    UIAlertAction *first = [UIAlertAction actionWithTitle:@"Concrete - 20Mpa" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self stringthDisplay:0];
    }];
    [controller addAction:first];
    
    UIAlertAction *second = [UIAlertAction actionWithTitle:@"Concrete - 25Mpa" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self stringthDisplay:1];
    }];
    [controller addAction:second];
    
    UIAlertAction *third = [UIAlertAction actionWithTitle:@"Concrete - 32Mpa" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self stringthDisplay:2];
    }];
    [controller addAction:third];
    
    UIAlertAction *fourth = [UIAlertAction actionWithTitle:@"Concrete - 40Mpa" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self stringthDisplay:3];
    }];
     [controller addAction:fourth];
    UIAlertAction *fifth = [UIAlertAction actionWithTitle:@"Concrete - 50Mpa" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self stringthDisplay:4];
    }];
     [controller addAction:fifth];
    UIAlertAction *sixth = [UIAlertAction actionWithTitle:@"Concrete - 60Mpa" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self stringthDisplay:5];
    }];
     [controller addAction:sixth];
    UIAlertAction *seventh = [UIAlertAction actionWithTitle:@"Concrete - 65Mpa" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self stringthDisplay:6];
    }];
    [controller addAction:seventh];
    
    UIAlertAction *eigth = [UIAlertAction actionWithTitle:@"Concrete - 80Mpa" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self stringthDisplay:7];
    }];
    [controller addAction:eigth];
    
    UIAlertAction *nineth = [UIAlertAction actionWithTitle:@"Concrete - 100Mpa" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self stringthDisplay:8];
    }];
    [controller addAction:nineth];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)userpreferenceSelect:(id)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Select"
                                                                        message:@"Currency Settings"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action) {
                                                            //NSLog(@"Dismiss button tapped!");
                                                        }];
    
    [controller addAction:alertAction];
    
    UIAlertAction *first = [UIAlertAction actionWithTitle:@"Dollar($)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self currencyDisplay:0];
    }];
    [controller addAction:first];
    
    UIAlertAction *second = [UIAlertAction actionWithTitle:@"Euro(€)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self currencyDisplay:1];
    }];
    [controller addAction:second];
    UIAlertAction *third = [UIAlertAction actionWithTitle:@"Yen(¥)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self currencyDisplay:2];
    }];
    [controller addAction:third];
    UIAlertAction *fourth = [UIAlertAction actionWithTitle:@"Pound(₤)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self currencyDisplay:3];
    }];
    [controller addAction:fourth];
    UIAlertAction *fifth = [UIAlertAction actionWithTitle:@"Franc(F)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self currencyDisplay:4];
    }];
    [controller addAction:fifth];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)userPreferenceDisplay:(int)value
{
    switch (value) {
        case 0:
            [_quotationbtn setTitle:@"Estimate" forState:UIControlStateNormal];
            break;
        case 1:
            [_quotationbtn setTitle:@"Estimate & Quote" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    preferenceindex = value;
}

-(void)currencyDisplay:(int)value
{
    switch (value) {
        case 0:
            [_quotationbtn setTitle:@"Dollar($)" forState:UIControlStateNormal];
            break;
        case 1:
            [_quotationbtn setTitle:@"Euro(€)" forState:UIControlStateNormal];
            break;
        case 2:
            [_quotationbtn setTitle:@"Yen(¥)" forState:UIControlStateNormal];
            break;
        case 3:
            [_quotationbtn setTitle:@"Pound(₤)" forState:UIControlStateNormal];
            break;
        case 4:
            [_quotationbtn setTitle:@"Franc(F)" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    currencyindex = value;
}

@end
