//
//  LeftViewController.m
//  DrawerControllerDemo
//
//  Created by 周宇 on 13-8-29.
//  Copyright (c) 2013年 周宇. All rights reserved.
//

#import "LeftViewController.h"
#import "DetailViewController.h"
@interface LeftViewController () {
    NSMutableArray *_menuArr;
}

@end

@implementation LeftViewController

- (void)dealloc
{
    [_menuArr release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _menuArr = [[NSMutableArray alloc] init];
        NSDictionary *mainVC = @{@"title": @"首页", @"class": @"CenterViewController"};
        NSDictionary *activityVC = @{@"title": @"活动", @"class": @"DetailViewController"};
        [_menuArr addObject:mainVC];
        [_menuArr addObject:activityVC];
        [_menuArr addObject:activityVC];
        [_menuArr addObject:activityVC];
        [_menuArr addObject:activityVC];
        [_menuArr addObject:activityVC];
        [_menuArr addObject:activityVC];
        [_menuArr addObject:activityVC];
        [_menuArr addObject:activityVC];
        [_menuArr addObject:activityVC];
        [_menuArr addObject:activityVC];
        [_menuArr addObject:activityVC];
        [_menuArr addObject:activityVC];
        [_menuArr addObject:activityVC];
        [_menuArr addObject:activityVC];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [[_menuArr objectAtIndex:indexPath.row] valueForKey:@"title"];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = [[_menuArr objectAtIndex:indexPath.row] valueForKey:@"class"];
    Class tempClass = NSClassFromString(className);
    if(!tempClass) return;
    UIViewController *tempVC = [[tempClass alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tempVC];
    [tempVC release];
    // 侧边栏回收的两种方式
    // [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
    [self.mm_drawerController setCenterViewController:nav withFullCloseAnimation:YES completion:nil];
    [nav release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
