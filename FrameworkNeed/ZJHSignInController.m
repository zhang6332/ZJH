//
//  ZJHSignInController.m
//  Tiantian
//
//  Created by Apple on 2017/5/13.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ZJHSignInController.h"
#import "ZJHSignUpController.h"
@interface ZJHSignInController ()

@end

@implementation ZJHSignInController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子视图
    [self addSubViews];
}

- (void)addSubViews {
    ZJHButtonStyleView * btView1 = [[ZJHButtonStyleView alloc]initWithFrame:CGRectMake(30, self.view.height / 4, self.view.width - 30 * 2, 40) andLeftTitle:@"账号:" andRightTextfieldText:@"请输入账号" withLimitTextLength:nil];
    btView1.textField.tag = 100;
    btView1.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:0.94f alpha:1.00f];
    btView1.layer.borderWidth = 0.5;
    btView1.layer.borderColor = colorWithSix(@"#949484").CGColor;
    
    ZJHButtonStyleView * btView2 = [[ZJHButtonStyleView alloc]initWithFrame:CGRectMake(btView1.x, CGRectGetMaxY(btView1.frame) + 10, btView1.width, btView1.height) andLeftTitle:@"密码:" andRightTextfieldText:@"请输入密码" withLimitTextLength:nil];
    btView2.textField.secureTextEntry = YES;
    btView2.textField.tag = 101;
    btView2.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:0.94f alpha:1.00f];
    btView2.layer.borderWidth = 0.5;
    btView2.layer.borderColor = colorWithSix(@"#949484").CGColor;
    
    [self.view addSubview:btView1];
    [self.view addSubview:btView2];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(btView1.x, CGRectGetMaxY(btView2.frame) + 20, btView1.width, 45)];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.86f green:0.72f blue:0.38f alpha:1.00f];
    [button addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton * button1 = [[UIButton alloc]initWithFrame:CGRectMake(btView1.x, CGRectGetMaxY(button.frame) + 15, 80, 25)];
    button1.titleLabel.font = [UIFont systemFontOfSize:13];
    [button1 setTitleColor:[UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:1.00f] forState:UIControlStateNormal];
    [button1 setTitle:@"用户注册" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame) - button1.width, CGRectGetMaxY(button.frame) + 15, button1.width, button1.height)];
    button2.titleLabel.font = [UIFont systemFontOfSize:13];
    [button2 setTitleColor:[UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:1.00f] forState:UIControlStateNormal];
    [button2 setTitle:@"忘记密码" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    [self.view addSubview:button2];

}

- (void)signUp:(UIButton *)button {
    ZJHSignUpController * signUpVC = [[ZJHSignUpController alloc]init];
    [self presentViewController:signUpVC animated:YES completion:nil];
}
- (void)forgetPassword:(UIButton *)button {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)loginButtonClicked:(UIButton *)button {
    [self.view endEditing:YES];
    UITextField * tf1 = [self.view viewWithTag:100];
    UITextField * tf2 = [self.view viewWithTag:101];
    
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc]init];
    
    if (tf1.text.length > 5) {
        [parametersDic setObject:tf1.text forKey:@"phone"];
    }else {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    if (tf2.text.length > 5) {
        [parametersDic setObject:tf2.text forKey:@"password"];
    }else {
        [MBProgressHUD showError:@"请输入至少六位密码"];
        return;
    }
    NSString * requestUrl = [NSString stringWithFormat:@"%@%@",ANCIENTMAP_SERVER,LOGIN_URL];
    
    [[ZJHAfnManager sharedManager] requestPOSTWithPath:requestUrl parameters:parametersDic submittingToken:NO showHUDToView:self.view success:^(ZJHModelResponse *response) {
        if ([response.code isEqualToString:@"100"]) {
            ZJHUserInfo * userInfo = [ZJHUserInfo mj_objectWithKeyValues:[response.result objectForKey:@"user"]];
            [ZJHUserInfoCoordinator saveUserInfo:userInfo withName:nil];
            [MBProgressHUD showSuccess:response.reason];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self back];
            });
        }else {
            [MBProgressHUD showError:response.reason];
        }
    } error:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}




@end
