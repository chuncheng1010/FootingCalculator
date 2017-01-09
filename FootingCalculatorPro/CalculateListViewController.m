//
//  CalculateListViewController.m
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import "CalculateListViewController.h"
#import "AppDelegate.h"
#import "CalculateCellTableViewCell.h"
#import "CalculationViewController.h"

@interface CalculateListViewController ()

@end

@implementation CalculateListViewController

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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    listdata = [[NSMutableArray alloc] init];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self getDataList];
}
-(void)getDataList
{
    [listdata removeAllObjects];
    sqlite3_stmt *selectStatement;
    char *selectSql = "SELECT id,title FROM jobs";
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    if (sqlite3_prepare_v2(delegate.db, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement)==SQLITE_ROW) {
            //id integer primary key autoincrement,date TEXT,name TEXT,address TEXT,phone TEXT,email TEXT,quote TEXT,method TEXT,option TEXT,value TEXT,height TEXT,width TEXT,length TEXT,margin TEXT,tax TEXT,title TEXT)
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            int no = sqlite3_column_int(selectStatement, 0);
            
            [data setObject:[NSString stringWithFormat:@"%d",no] forKey:@"id"];
            [data setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)] forKey:@"title"];
            NSString * str = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            NSLog(@"%@",str);
            [listdata addObject:data];
            
        }
        
    }
    //statement close
    sqlite3_finalize(selectStatement);
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return listdata.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"celltable";
    
    CalculateCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[CalculateCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic = [listdata objectAtIndex:indexPath.row];
    cell.title.text = [dic objectForKey:@"title"];
    cell.delbutton.tag = [[dic objectForKey:@"id"] intValue];
    [cell.delbutton addTarget:self action:@selector(recordremove:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)recordremove:(UIButton *)sender
{
    selectedid = sender.tag;
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Would you like to delete this job?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [view show];
    view.tag = 1;
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1 && buttonIndex == 0)
    {
        sqlite3_stmt *statement;
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        char *selectSql = "delete FROM jobs where id=?";
        if (sqlite3_prepare_v2(delegate.db, selectSql, -1, &statement, NULL) == SQLITE_OK) {
            sqlite3_bind_int(statement, 1, selectedid);
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"Error");
                
            }
            sqlite3_finalize(statement);
            [self getDataList];
        }
    }
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    CalculationViewController *detailController =segue.destinationViewController;
    CalculateCellTableViewCell *button = (CalculateCellTableViewCell *)sender;
    detailController.index = (int)button.delbutton.tag;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedid = (int)indexPath.row;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs stringForKey:@"preference"] == nil || [[prefs stringForKey:@"preference"] intValue] == 0)
    
    {
        /*
        CalculationResult *result = [[CalculationResult alloc] initWithNibName:@"CalculationResult" bundle:nil];
        result.data = [listdata objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:result animated:YES];
        [result release];
         */
    }
    else
    {
        /*
        QuotationResult *result = [[QuotationResult alloc] initWithNibName:@"QuotationResult" bundle:nil];
        result.data = [listdata objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:result animated:YES];
        [result release];
         */
    }
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
