//
//  ZJHButtonStyleView.m
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "ZJHButtonStyleView.h"
@interface ZJHButtonStyleView()<UITextFieldDelegate,UITextViewDelegate>


@end

@implementation ZJHButtonStyleView

//左label 右输入框
- (instancetype)initWithFrame:(CGRect)frame andLeftTitle:(NSString *)leftTitle
        andRightTextfieldText:(NSString *)tfText withLimitTextLength:(NSNumber *)textLength {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, self.frame.size.height)];

        self.leftLabel.backgroundColor = [UIColor whiteColor];
        self.leftLabel.text = leftTitle;
        CGSize size = [self.leftLabel sizeThatFits:CGSizeMake(self.leftLabel.width, self.leftLabel.height)];
        self.leftLabel.width = size.width;
        self.leftLabel.font = [UIFont systemFontOfSize:15];
        self.leftLabel.textColor = [UIColor colorWithRed:0.30f green:0.30f blue:0.30f alpha:1.00f];
        UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width - 15, self.leftLabel.frame.origin.y, 15, self.leftLabel.frame.size.height)];
        rightView.backgroundColor = [UIColor whiteColor];
        //输入框
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(self.leftLabel.frame.origin.x + self.leftLabel.frame.size.width, self.leftLabel.frame.origin.y,self.frame.size.width - (self.leftLabel.frame.origin.x + self.leftLabel.frame.size.width + rightView.frame.size.width), self.leftLabel.frame.size.height)];
        self.textField.delegate = self;
        self.textField.backgroundColor = [UIColor whiteColor];
        self.textField.placeholder = tfText;
        self.textField.textColor = [UIColor colorWithRed:0.30f green:0.30f blue:0.30f alpha:1.00f];
        self.textField.font = [UIFont systemFontOfSize:13];
        //键盘类型
//        self.textField.keyboardType = UIKeyboardTypeDecimalPad;
        // 设置是否在编辑时清空文本
        //self.textField.clearsOnBeginEditing = YES;
        // 设置清空按钮显示模式
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        //监听输入字符长度
        if (textLength) {
            self.textField.parameterStr = [NSMutableString stringWithFormat:@"%@",textLength];
        }else {
            self.textField.parameterStr = [NSMutableString stringWithFormat:@"%d",99];
        }
        [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

        [self addSubview:rightView];
        [self addSubview:self.leftLabel];
        [self addSubview:self.textField];

    }
    return self;
}

//左label 中输入框 右button
- (instancetype)initWithFrame:(CGRect)frame andLeftTitle:(NSString *)leftTitle
       andMiddleTextfieldText:(NSString *)tfText andRightButtonTitle:(NSString *)buttonTitle withLimitTextLength:(NSNumber *)textLength {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 130, self.frame.size.height)];
        self.leftLabel.backgroundColor = [UIColor whiteColor];
        self.leftLabel.text = leftTitle;
        self.leftLabel.font = [UIFont systemFontOfSize:15];
        self.leftLabel.textColor = [UIColor blackColor];
        CGSize size = [self.leftLabel sizeThatFits:CGSizeMake(self.leftLabel.width, self.leftLabel.height)];
        self.leftLabel.width = size.width;
        
        //按钮
        self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 75, 0, 65, self.frame.size.height - 10)];
        self.rightButton.center = CGPointMake(self.rightButton.center.x, self.leftLabel.center.y);
        self.rightButton.contentMode = UIViewContentModeScaleAspectFit;
        //设置背景颜色
        self.rightButton.backgroundColor = [UIColor whiteColor];
        self.rightButton.contentMode = UIViewContentModeScaleAspectFit;
        [self.rightButton setTitle:buttonTitle forState:UIControlStateNormal];
        self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        self.rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [self.rightButton setImage:[UIColor imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];

        //输入框
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame), self.leftLabel.frame.origin.y,CGRectGetMinX(self.rightButton.frame) - CGRectGetMaxX(self.leftLabel.frame) - 5, self.leftLabel.frame.size.height)];
        self.textField.delegate = self;
        self.textField.center = CGPointMake(self.textField.center.x, self.leftLabel.center.y);
        self.textField.backgroundColor = [UIColor whiteColor];
        self.textField.placeholder = tfText;
        self.textField.textColor = [UIColor blackColor];
        self.textField.font = [UIFont systemFontOfSize:15];
        //键盘类型
        //self.textField.keyboardType = UIKeyboardTypeDecimalPad;
        // 设置是否在编辑时清空文本
        //self.textField.clearsOnBeginEditing = YES;
        // 设置清空按钮显示模式
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        //监听输入字符长度
        if (textLength) {
            self.textField.parameterStr = [NSMutableString stringWithFormat:@"%@",textLength];
        }else {
            self.textField.parameterStr = [NSMutableString stringWithFormat:@"%d",99];
        }
        [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

        [self addSubview:self.rightButton];
        [self addSubview:self.leftLabel];
        [self addSubview:self.textField];
        
    }
    return self;
}

//左label 中TextView 右button
- (instancetype)initWithFrame:(CGRect)frame andLeftTitle:(NSString *)leftTitle
       andMiddleTextViewText:(NSString *)tfText andRightButtonTitle:(NSString *)buttonTitle withLimitTextLength:(NSNumber *)textLength {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 130, self.frame.size.height)];
        self.leftLabel.backgroundColor = [UIColor whiteColor];
        self.leftLabel.text = leftTitle;
        self.leftLabel.font = [UIFont systemFontOfSize:15];
        self.leftLabel.textColor = [UIColor blackColor];
        CGSize size = [self.leftLabel sizeThatFits:CGSizeMake(self.leftLabel.width, self.leftLabel.height)];
        self.leftLabel.width = size.width;
        
        //按钮
        self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 75, 0, 60, 30)];
        self.rightButton.center = CGPointMake(self.rightButton.center.x, self.frame.size.height / 2);
        self.rightButton.contentMode = UIViewContentModeScaleAspectFit;
        //设置背景颜色
        self.rightButton.backgroundColor = [UIColor whiteColor];
        self.rightButton.contentMode = UIViewContentModeScaleAspectFit;
        [self.rightButton setTitle:buttonTitle forState:UIControlStateNormal];
        self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        self.rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [self.rightButton setImage:[UIColor imageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
        
        //输入框
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame), self.leftLabel.frame.origin.y,CGRectGetMinX(self.rightButton.frame) - CGRectGetMaxX(self.leftLabel.frame) - 5, self.frame.size.height)];
        self.textView.layer.borderWidth = 1;
        self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.textView.layer.shadowColor = [UIColor grayColor].CGColor;
        self.textView.delegate = self;
        self.textView.center = CGPointMake(self.textView.center.x, self.frame.size.height / 2);
        //是否允许编辑内容，默认为“YES”
        self.textView.editable = YES;
        //当文字超过视图的边框时是否允许滑动，默认为“YES”
        self.textView.scrollEnabled = YES;
        //文本显示的位置默认为居左
        self.textView.textAlignment = NSTextAlignmentLeft;
        //显示数据类型的连接模式（如电话号码、网址、地址等
        self.textView.dataDetectorTypes = UIDataDetectorTypeAll;
        self.textView.backgroundColor = [UIColor whiteColor];
        self.textView.textColor = [UIColor grayColor];
        self.textView.font = [UIFont systemFontOfSize:13];
        self.textView.text = tfText;

        //键盘类型
        //self.textView.keyboardType = UIKeyboardTypeDecimalPad;
        //监听输入字符长度
        if (textLength) {
            self.textView.parameterStr = [NSMutableString stringWithFormat:@"%@",textLength];
        }else {
            self.textView.parameterStr = [NSMutableString stringWithFormat:@"%d",506];
        }
        [self addSubview:self.rightButton];
        [self addSubview:self.leftLabel];
        [self addSubview:self.textView];
    }
    return self;
}


//左输入框 右button
- (instancetype)initWithFrame:(CGRect)frame andLeftTextfieldText:(NSString *)tfText andRightButtonTitle:(NSString *)buttonTitle withLimitTextLength:(NSNumber *)textLength {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //按钮
        self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 100, 15, 80, self.frame.size.height - 30)];
        self.rightButton.backgroundColor = [UIColor whiteColor];
        [self.rightButton setTitle:buttonTitle forState:UIControlStateNormal];
        self.rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
        self.rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
        self.rightButton.clipsToBounds = YES;
        self.rightButton.layer.cornerRadius = 2;
        self.rightButton.layer.borderWidth = 1;
        self.rightButton.layer.borderColor = [UIColor grayColor].CGColor;
        [self.rightButton setTitleColor:[UIColor colorWithRed:0.29f green:0.58f blue:0.92f alpha:1.00f] forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f] forState:UIControlStateHighlighted];
        //输入框
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(20,0,self.rightButton.frame.origin.x - 20, self.frame.size.height)];
        self.textField.delegate = self;
        self.textField.backgroundColor = [UIColor whiteColor];
        self.textField.placeholder = tfText;
        self.textField.textColor = [UIColor colorWithRed:0.30f green:0.30f blue:0.30f alpha:1.00f];
        self.textField.font = [UIFont systemFontOfSize:13];
//        self.textField.textAlignment = NSTextAlignmentCenter;
        //键盘类型
        // self.textField.keyboardType = UIKeyboardTypeDecimalPad;
        // 设置是否在编辑时清空文本
        //self.textField.clearsOnBeginEditing = YES;
        // 设置清空按钮显示模式
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        //监听输入字符长度
        if (textLength) {
            self.textField.parameterStr = [NSMutableString stringWithFormat:@"%@",textLength];
        }else {
            self.textField.parameterStr = [NSMutableString stringWithFormat:@"%d",99];
        }
        [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.rightButton];
        [self addSubview:self.textField];
        
    }
    return self;

}

//左label 右label
- (instancetype)initWithFrame:(CGRect)frame andleftLabelTitle:(NSString *) string1 rightLabelTitle: (NSString *) string2 {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,0,160,self.frame.size.height)];
        self.leftLabel.font = [UIFont systemFontOfSize:15];
        self.leftLabel.textColor = [UIColor blackColor];
        self.leftLabel.text = string1;
        CGSize size = [self.leftLabel sizeThatFits:CGSizeMake(self.leftLabel.width, self.leftLabel.height)];
        self.leftLabel.width = size.width;
       
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame),self.leftLabel.frame.origin.y,self.frame.size.width - self.leftLabel.frame.origin.x - CGRectGetMaxX(self.leftLabel.frame),self.frame.size.height)];
        self.rightLabel.text = string2;
        self.rightLabel.textColor = [UIColor colorWithRed:0.30f green:0.30f blue:0.30f alpha:1.00f];
        self.self.rightLabel.font = [UIFont systemFontOfSize:15];
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];

    }
    return self;
}


//左图片 右图片 中上左label 中上右label 中下label

- (instancetype) initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage leftTopTitle:(NSString *)leftTitle rightTopTitle:(NSString *)rightTitle bottomTitle:(NSString *)bottomTitle andRightImage:(UIImage *)rightImage {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 40, 40)];
        self.leftImageView.center = CGPointMake(self.leftImageView.center.x,self.height / 2);
        self.leftImageView.image = leftImage;
        self.leftImageView.contentMode = UIViewContentModeScaleToFill;
        
        self.rightImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 55,0,25,25)];
        self.rightImageView.center = CGPointMake(self.rightImageView.center.x,self.height / 2);
        self.rightImageView.image = rightImage;
        self.rightImageView.contentMode = UIViewContentModeScaleToFill;

        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftImageView.frame) + 3, 0, (CGRectGetMinX(self.rightImageView.frame)- CGRectGetMaxX(self.leftImageView.frame) - 6) / 2  , self.frame.size.height / 2)];
        self.leftLabel.text = leftTitle;
        self.leftLabel.font = [UIFont systemFontOfSize:15];
        self.leftLabel.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
        self.leftLabel.textAlignment = NSTextAlignmentLeft;
        
        self.rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame) + 3, self.leftLabel.frame.origin.y, self.leftLabel.frame.size.width, self.leftLabel.frame.size.height)];
        self.rightLabel.text = rightTitle;
        self.rightLabel.font = [UIFont systemFontOfSize:15];
        self.rightLabel.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
        self.rightLabel.textAlignment = NSTextAlignmentLeft;
        
        self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.leftLabel.frame.origin.x, CGRectGetMaxY(self.leftLabel.frame), CGRectGetMinX(self.rightImageView.frame) - CGRectGetMaxX(self.leftImageView.frame),self.leftLabel.frame.size.height)];
        self.bottomLabel.text = bottomTitle;
        self.bottomLabel.numberOfLines = 0;
        self.bottomLabel.font = [UIFont systemFontOfSize:15];
        self.bottomLabel.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
        self.bottomLabel.textAlignment = NSTextAlignmentLeft;

        [self addSubview:self.leftImageView];
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];
        [self addSubview:self.bottomLabel];
        [self addSubview:self.rightImageView];
        
    }
    
    return self;

}


//自定制选择按钮
- (instancetype) initWithFrame:(CGRect)frame delegate:(id)delegate andTitleArray:(NSArray *)array setImageleft:(BOOL)leftBool {
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        self.backgroundColor = [UIColor whiteColor];
        for (int i = 0 ; i < array.count; i++) {
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, i * self.frame.size.height / array.count, self.frame.size.width,self.frame.size.height / array.count)];
            button.tag = 506506 + i;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(button.frame.size.width - 30, 0, 20, 20)];
            if (leftBool) {
                imageView.x = 0;
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [button setTitleEdgeInsets:UIEdgeInsetsMake(0,imageView.width + 5,0,0)];
            }else {
                imageView.x = CGRectGetMaxX(button.frame) - imageView.width;
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                [button setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,imageView.width + 5)];
            }
            imageView.center = CGPointMake(imageView.center.x, button.height / 2);
            imageView.image = [UIImage imageNamed:@"off"];
            [button addSubview:imageView];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [self buttonClicked:button];
            }
            [self addSubview:button];
        }
    }
    return self;
}

- (void)buttonClicked:(UIButton*)button {
    self.currentimage.image = [UIImage imageNamed:@"off"];
    UIImageView * imageView = [[UIImageView alloc]init];
    for (UIView * view in button.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            imageView = (UIImageView *)view;
        }
    }
    imageView.image = [UIImage imageNamed:@"on"];
    self.currentimage = imageView;
    self.currentButton.selected = NO;
    button.selected = YES;
    self.currentButton = button;
    
    id object = nil;
    if (self.parameterStr) {
        object = @{@"index" : @(button.tag - 506506),@"type" : self.parameterStr};
    }else {
        object = @(button.tag - 506506).stringValue;
    }
    [self reportDelegateMethodWithSelectedTitle:button.titleLabel.text parameterObject:object];
}

- (void)reportDelegateMethodWithSelectedTitle:(NSString *)selectedTitle parameterObject:(id)object {
    if ([self.delegate respondsToSelector:@selector(ZJHButtonStyleViewDelegate:selectedTitle:parameterObject:)]) {
        [self.delegate ZJHButtonStyleViewDelegate:self selectedTitle:selectedTitle parameterObject:object];
    }
}


//平分视图添加button
- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate normalImageNameArray:(NSArray *) imageNames SelectedImageNameArray:(NSArray *)selectedImageNames andbottomTitles:(NSArray *)titles withLayerCornerRadiusScale:(NSNumber *)cornerRadius {
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        float width = self.width / imageNames.count;
        float height = self.height;
        for (int i = 0; i < imageNames.count; i++) {
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, height, height)];
            button.center = CGPointMake((i + 1) * width - width / 2 , self.height / 2);
            button.tag = 605605 + i;
            [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:selectedImageNames[i]] forState:UIControlStateSelected];
            if (titles.count) {
                button.titleLabel.adjustsFontSizeToFitWidth = YES;
                button.titleLabel.font = [UIFont systemFontOfSize:12];
                [button setTitle:titles[i] forState:UIControlStateNormal];
                [button layoutButtonWithEdgeInsetsStyle:ZJHButtonEdgeInsetsStyleTop imageTitleSpace:nil];
                [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithRed:0.03f green:0.50f blue:1.00f alpha:1.00f] forState:UIControlStateHighlighted];
                [button setTitleColor:[UIColor colorWithRed:0.03f green:0.50f blue:1.00f alpha:1.00f] forState:UIControlStateSelected];
            }
            if (cornerRadius) {
                button.clipsToBounds = YES;
                button.layer.cornerRadius = button.height * cornerRadius.floatValue;
                button.backgroundColor = [UIColor whiteColor];
            }
            [button addTarget:self action:@selector(subButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    return self;
}
- (void)subButtonClicked:(UIButton*)button {
    self.currentButton.selected = NO;
    button.selected = YES;
    self.currentButton = button;
    id object = nil;
    if (self.parameterStr) {
        object = @{@"index" : @(button.tag - 605605),@"type" : self.parameterStr};
    }else {
        object = @(button.tag - 605605);
    }
    [self reportDelegateMethodWithSelectedTitle:button.titleLabel.text parameterObject:object];
}



//左图片 右label
- (instancetype) initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage rightTitle:(NSString *)rightTitle {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, (self.frame.size.height - 20) / 2, 20, 20)];
        self.leftImageView.image = leftImage;
        self.leftImageView.contentMode = UIViewContentModeScaleToFill;
        
        self.rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftImageView.frame) + 3, 0, self.frame.size.width - CGRectGetMaxX(self.leftImageView.frame) - 18, self.frame.size.height)];
        self.rightLabel.text = rightTitle;
        self.rightLabel.font = [UIFont systemFontOfSize:15];
        self.rightLabel.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
        self.rightLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:self.leftImageView];
        [self addSubview:self.rightLabel];
        
    }
    
    return self;
}



//上label 下view
- (instancetype) initWithFrame:(CGRect)frame andTitle:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.leftLabel.font = [UIFont systemFontOfSize:15];
        self.leftLabel.text = title;
        self.leftLabel.numberOfLines = 0;
        self.leftLabel.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
        self.leftLabel.textAlignment = NSTextAlignmentCenter;
        
        self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.leftLabel.frame), self.frame.size.width, 1)];
        self.bottomView.backgroundColor = [UIColor clearColor];
        [self.leftLabel addSubview:self.bottomView];
        
        [self addSubview:self.leftLabel];

    }
    return self;
}


//上图片 中label 底label
- (instancetype) initWithFrame:(CGRect)frame topImage:(UIImage *)topImage andMiddleTitle:(NSString *)Middletitle andBottomTitle:(NSString *)bottomTitle {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width * 4 / 5, self.width * 4 / 5)];
        self.leftImageView.center = CGPointMake(self.frame.size.width / 2, self.leftImageView.center.y);
        self.leftImageView.image = topImage;
        self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.leftImageView.frame) + 5, self.frame.size.width - 20 , 35)];
        self.leftLabel.text = Middletitle;
        self.leftLabel.numberOfLines = 0;
        self.leftLabel.font = [UIFont systemFontOfSize:14];
        self.leftLabel.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
        self.leftLabel.textAlignment = NSTextAlignmentCenter;
        CGSize size = [self.leftLabel sizeThatFits:CGSizeMake(self.leftLabel.width, self.leftLabel.height)];
        self.leftLabel.height = size.height;
        
        self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.leftLabel.frame.origin.x, CGRectGetMaxY(self.leftLabel.frame) + 5, self.leftLabel.frame.size.width,self.frame.size.height - CGRectGetMaxY(self.leftLabel.frame))];
        self.bottomLabel.text = bottomTitle;
        self.bottomLabel.numberOfLines = 0;
        self.bottomLabel.font = [UIFont systemFontOfSize:13];
        self.bottomLabel.textColor = [UIColor colorWithRed:0.40f green:0.40f blue:0.40f alpha:1.00f];
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
        CGSize bottomSize = [self.bottomLabel sizeThatFits:CGSizeMake(self.bottomLabel.frame.size.width, self.leftLabel.frame.size.height)];
        if (bottomSize.height > self.bottomLabel.height) {
            self.bottomLabel.height = bottomSize.height;
        }
        //调整控件高度
        self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(self.bottomLabel.frame));
        
        [self addSubview:self.leftImageView];
        [self addSubview:self.leftLabel];
        [self addSubview:self.bottomLabel];
    }
    return self;

}


//中label 右图片
- (instancetype) initWithFrame:(CGRect)frame leftLabelTitle:(NSString *)leftLabelTitle andRightImage:(UIImage *)rightImage {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 4, 0, self.frame.size.width / 4 + 30, self.frame.size.height)];
        self.leftLabel.font = [UIFont systemFontOfSize:14];
        self.leftLabel.textAlignment = NSTextAlignmentRight;
        self.leftLabel.textColor = colorWithSix(@"#333333");
        self.leftLabel.text = leftLabelTitle;
        
        self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame) + 12, 0, 10, 10)];
        self.rightImageView.center = CGPointMake(self.rightImageView.center.x, self.leftLabel.center.y);
        self.rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.rightImageView.image = rightImage;
        
        
        [self addSubview:self.rightImageView];
        [self addSubview:self.leftLabel];

           }
    return self;
}

//左图右图中label
- (instancetype) initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage middleLabelTitle:(NSString *)middleLabelTitle andRightImage:(UIImage *)rightImage {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width / 4, self.frame.size.height)];
        self.leftLabel.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        self.leftLabel.font = [UIFont systemFontOfSize:14];
        self.leftLabel.textAlignment = NSTextAlignmentCenter;
        self.leftLabel.textColor = colorWithSix(@"#333333");
        self.leftLabel.text = middleLabelTitle;
        
        self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.leftLabel.frame) - 10, 0, 10, 10)];
        self.leftImageView.center = CGPointMake(self.leftImageView.center.x, self.leftLabel.center.y);
        self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.leftImageView.image = leftImage;

        
        self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame), 0, 10, 10)];
        self.rightImageView.center = CGPointMake(self.rightImageView.center.x, self.leftLabel.center.y);
        self.rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.rightImageView.image = rightImage;
        
        [self addSubview:self.leftImageView];
        [self addSubview:self.rightImageView];
        [self addSubview:self.leftLabel];
        
    }
    return self;

}

//左图右button中label
- (instancetype) initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage middleLabelTitle:(NSString *)middleLabelTitle andRightButtonTitle:(NSString *)rightButtonTitle {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width * 7 / 15, self.frame.size.height)];
        self.leftLabel.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        self.leftLabel.font = [UIFont systemFontOfSize:14];
        self.leftLabel .numberOfLines = 0;
        self.leftLabel.adjustsFontSizeToFitWidth = YES;
        self.leftLabel.textAlignment = NSTextAlignmentCenter;
        self.leftLabel.textColor = colorWithSix(@"#333333");
        self.leftLabel.text = middleLabelTitle;

        self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        self.leftImageView.center = CGPointMake(self.width / 5, self.leftLabel.center.y);
        self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.leftImageView.image = leftImage;
        
        self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        self.rightButton.center = CGPointMake(self.width * 4 / 5, self.leftLabel.center.y);
        self.rightButton.contentMode = UIViewContentModeScaleAspectFill;
        [self.rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];;
        
        [self addSubview:self.leftImageView];
        [self addSubview:self.rightButton];
        [self addSubview:self.leftLabel];
        
    }
    return self;
    
}


//textfieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
//监听输入长度
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > textField.parameterStr.intValue) {
        textField.text = [textField.text substringToIndex:textField.parameterStr.intValue];
    }
}
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > textView.parameterStr.intValue) {
        textView.text = [textView.text substringToIndex:textView.parameterStr.intValue];
    }
}

@end
