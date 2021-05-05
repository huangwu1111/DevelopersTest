//
//  FirViewController.m
//  DuoRenKaiFa
//
//  Created by 黄武 on 2021/5/5.
//

#import "FirViewController.h"
#import "NetworkTool.h"
@interface FirViewController ()

@end

@implementation FirViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    // Do any additional setup after loading the view.
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
