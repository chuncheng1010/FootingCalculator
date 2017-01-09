//
//  AppDelegate.h
//  FootingCalculatorPro
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <sqlite3.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    sqlite3 *db;
}

@property (strong, nonatomic) UIWindow *window;

@property (assign) sqlite3 *db;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;

@end

