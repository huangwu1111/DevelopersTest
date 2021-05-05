//
//  ViewController.m
//  DuoRenKaiFa
//
//  Created by 黄武 on 2021/5/4.
//

#import "ViewController.h"
#import "NetworkTool.h"
#import "FirViewController.h"

NSString * const urlFront = @"http://49.4.28.208:1016";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self loadData];
    [self loadData];
    [self loadData];
    [self loadData];
    [self loadData];
    [self loadData];

    
    
    // Do any additional setup after loading the view.
}
-(void)loadData{
    NSString *uid = @"844499127001";
    if (!uid) return;
    NSDictionary *dic;
    dic = @{
        @"user_id":uid,
    };
    [[NetworkTool shareNetworkTool] postWithUrlStr:@"/changePowers" parameters:dic success:^(id response) {
        NSLog(@"%@",response);
    } fail:^(NSError *err) {
        NSLog(@"%@", err);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[FirViewController new] animated:YES];
}
@end
