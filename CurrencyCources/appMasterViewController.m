//
//  appMasterViewController.m
//  CurrencyCources
//
//  Created by Alexander on 17.08.13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "appMasterViewController.h"

#import "appDetailViewController.h"


@interface appMasterViewController () {
    NSArray *_organizations;
}
@end

@implementation appMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // This application uses api from http://resources.finance.ua
    if(! _organizations) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://resources.finance.ua/ru/public/currency-cash.json"]];
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSError *jsonParsingError = nil;
        NSDictionary *allObjects = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
        _organizations = [allObjects valueForKey:@"organizations"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _organizations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = [_organizations[indexPath.row] valueForKey:@"title"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *organization = _organizations[indexPath.row];
        [[segue destinationViewController] setDetailItem:organization];
    }
}

@end
