//
//  appDetailViewController.m
//  CurrencyCources
//
//  Created by Alexander on 17.08.13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "appDetailViewController.h"

@interface appDetailViewController ()
- (void)configureView;
@end

@implementation appDetailViewController {
    NSDictionary *_currencies;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        _currencies = [_detailItem valueForKey:@"currencies"];
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
/*
    if (self.detailItem) {
        self.navigationItem.title = [self.detailItem valueForKey:@"title"];
    }
 */
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = [_detailItem valueForKey:@"title"];
    [self configureView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _currencies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *currencyName =[self getCurrencyByIndex:indexPath.row];
    NSDictionary *course = [_currencies valueForKey:currencyName];
    NSString *ask = [course valueForKey:@"ask"];
    NSString *bid = [course valueForKey: @"bid"];
    
    cell.textLabel.text = currencyName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ / %@", ask, bid];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (NSDictionary*) getCurrencyByIndex: (NSInteger) index {
    NSArray *keys = [_currencies allKeys];
    return keys[index];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
