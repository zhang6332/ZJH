//
//  ZJHSignUpController.m
//  Tiantian
//
//  Created by Apple on 2017/5/16.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ZJHSignUpController.h"

@interface ZJHSignUpController ()

@end

@implementation ZJHSignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子视图
    [self addSubviews];
}

- (void)addSubviews {
    
    ZJHButtonStyleView * btView1 = [[ZJHButtonStyleView alloc]initWithFrame:CGRectMake(30, self.view.height / 4, self.view.width - 30 * 2, 40) andLeftTitle:@"手机号:" andRightTextfieldText:@"请输入手机号" withLimitTextLength:nil];
    btView1.textField.tag = 201;
    btView1.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:0.94f alpha:0.5];
    btView1.layer.borderWidth = 0.5;
    btView1.layer.borderColor = colorWithSix(@"#949484").CGColor;
    
    ZJHButtonStyleView * btView2 = [[ZJHButtonStyleView alloc]initWithFrame:CGRectMake(btView1.x, CGRectGetMaxY(btView1.frame) + 10, btView1.width, btView1.height) andLeftTitle:@"手机验证码: " andMiddleTextfieldText:@"请输入手机验证码" andRightButtonTitle:@"获取验证码" withLimitTextLength:@10];
    btView2.rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [btView2.rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btView2.rightButton addTarget:self action:@selector(sendCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
    btView2.textField.tag = 202;
    btView2.layer.borderWidth = 0.5;
    btView2.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:0.94f alpha:0.5];
    btView2.layer.borderColor = colorWithSix(@"#949484").CGColor;
    
    ZJHButtonStyleView * btView3 = [[ZJHButtonStyleView alloc]initWithFrame:CGRectMake(btView1.x, CGRectGetMaxY(btView2.frame) + 10, btView1.width, btView1.height) andLeftTitle:@"密码:" andRightTextfieldText:@"请输入密码" withLimitTextLength:nil];
    btView3.textField.tag = 203;
    btView3.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:0.94f alpha:0.5];
    btView3.layer.borderWidth = 0.5;
    btView3.layer.borderColor = colorWithSix(@"#949484").CGColor;
    
    ZJHButtonStyleView * btView4 = [[ZJHButtonStyleView alloc]initWithFrame:CGRectMake(btView1.x, CGRectGetMaxY(btView3.frame) + 10, btView1.width, btView1.height) andLeftTitle:@"确认密码:" andRightTextfieldText:@"请再次输入密码" withLimitTextLength:nil];
    btView4.textField.tag = 204;
    btView4.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:0.94f alpha:0.5];
    btView4.layer.borderWidth = 0.5;
    btView4.layer.borderColor = colorWithSix(@"#949484").CGColor;

    [self.view addSubview:btView1];
    [self.view addSubview:btView2];
    [self.view addSubview:btView3];
    [self.view addSubview:btView4];

    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(btView1.x, CGRectGetMaxY(btView4.frame) + 50, btView1.width, 45)];
    [button setTitle:@"注册" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.backgroundColor = [UIColor colorWithRed:0.86f green:0.72f blue:0.38f alpha:1.00f];
    [button addTarget:self action:@selector(rigesterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)sendCodeClicked:(UIButton *)button {

    static NSTimer * timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerBeginRun:) userInfo:button repeats:YES];
    [timer setFireDate:[NSDate distantPast]];
}

- (void)timerBeginRun:(NSTimer *)timer {
    static int time = 60;
    UIButton * button = timer.userInfo;
    if (time >= 0) {
        [button setTitle:[NSString stringWithFormat:@"%d",time] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.enabled = NO;
    }else {
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button.enabled = YES;
        [timer invalidate];
        timer = nil;
        time = 60;
    }
    time--;
}

- (void)rigesterButtonClicked:(UIButton *)button {
    [self.view endEditing:YES];
    UITextField * tf1 = [self.view viewWithTag:201];
    UITextField * tf2 = [self.view viewWithTag:202];
    UITextField * tf3 = [self.view viewWithTag:203];
    UITextField * tf4 = [self.view viewWithTag:204];
    
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc]init];
    
    if (tf1.text.length > 5) {
        if ([NSString chackMobileFormat:tf1.text]) {
            [parametersDic setObject:tf1.text forKey:@"phone"];
        }else {
            [MBProgressHUD showError:@"请输入有效的手机号"];
        }
    }else {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    if (tf3.text.length > 5) {
        [parametersDic setObject:tf3.text forKey:@"password"];
    }else {
        [MBProgressHUD showError:@"请输入至少六位密码"];
        return;
    }
    if (tf4.text.length > 5) {
        
        if (![tf4.text isEqualToString:tf3.text]) {
            [MBProgressHUD showError:@"两次输入密码不一致"];
            return;
        }
    }else {
        [MBProgressHUD showError:@"请输入至少六位确认密码"];
        return;
    }
    if (tf2.text.length) {
        if ([NSString isValidateEmail:tf2.text]) {
            [parametersDic setObject:tf2.text forKey:@"mailbox"];
        }else {
            [MBProgressHUD showError:@"邮箱格式不正确"];
            return;
        }
    }else {
        [MBProgressHUD showError:@"请输入邮箱"];
        return;
    }
    [parametersDic setObject:@"0" forKey:@"type"];
    NSString * requestUrl = [NSString stringWithFormat:@"%@%@",ANCIENTMAP_SERVER,REGISTER_URL];
    [[ZJHAfnManager sharedManager] requestPOSTWithPath:requestUrl parameters:parametersDic submittingToken:NO showHUDToView:self.view success:^(ZJHModelResponse *response) {
        if ([response.code isEqualToString:@"100"]) {
            [MBProgressHUD showSuccess:response.reason];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
