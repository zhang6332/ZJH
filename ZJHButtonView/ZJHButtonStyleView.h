//
//  ZJHButtonStyleView.h
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJHButtonStyleView;
@protocol ZJHButtonStyleViewDelegate <NSObject>

- (void)ZJHButtonStyleViewDelegate:(ZJHButtonStyleView *)styleView selectedTitle:(NSString *)selectedTitle parameterObject:(id)object;

@end

@interface ZJHButtonStyleView : UIButton

@property (nonatomic ,weak) id<ZJHButtonStyleViewDelegate> delegate;


//输入框字符长度设定
@property (nonatomic ,copy) NSString * tfLength;

@property (nonatomic,strong) UITextField * textField;
@property (nonatomic,strong) UITextView * textView;

//右按钮
@property (nonatomic,strong) UIButton * rightButton;
//左文本 右输入框
- (instancetype)initWithFrame:(CGRect)frame andLeftTitle:(NSString *)leftTitle
        andRightTextfieldText:(NSString *)tfText withLimitTextLength:(NSNumber *)textLength;

//左文本 中输入框 右按钮
- (instancetype)initWithFrame:(CGRect)frame andLeftTitle:(NSString *)leftTitle
       andMiddleTextfieldText:(NSString *)tfText andRightButtonTitle:(NSString *)buttonTitle withLimitTextLength:(NSNumber *)textLength;
//左label 中textView 右button
- (instancetype)initWithFrame:(CGRect)frame andLeftTitle:(NSString *)leftTitle
        andMiddleTextViewText:(NSString *)tfText andRightButtonTitle:(NSString *)buttonTitle withLimitTextLength:(NSNumber *)textLength;

//左输入框 右按钮图片  图片验证码
- (instancetype)initWithFrame:(CGRect)frame andLeftTextfieldText:(NSString *)tfText andRightButtonTitle:(NSString *)buttonTitle withLimitTextLength:(NSNumber *)textLength;

//左 label 右 label
@property (nonatomic ,strong) UILabel * leftLabel;
@property (nonatomic ,strong) UILabel * rightLabel;
- (instancetype)initWithFrame:(CGRect)frame andleftLabelTitle:(NSString *) string1 rightLabelTitle: (NSString *) string2 ;

//左图片 右图片 中上左label 中上右label 中下label

@property (nonatomic,strong) UILabel * bottomLabel;
@property (nonatomic,strong) UIImageView * leftImageView;
@property (nonatomic,strong) UIImageView * rightImageView;
- (instancetype) initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage leftTopTitle:(NSString *)leftTitle rightTopTitle:(NSString *)rightTitle bottomTitle:(NSString *)bottomTitle andRightImage:(UIImage *)rightImage;

//自定制选择按钮
@property (nonatomic,strong)UIImageView * currentimage;
@property (nonatomic,strong)UIButton * currentButton;

- (instancetype) initWithFrame:(CGRect)frame delegate:(id)delegate andTitleArray:(NSArray *)array setImageleft:(BOOL)leftBool;

//平分视图添加button
- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate normalImageNameArray:(NSArray *) imageNames SelectedImageNameArray:(NSArray *)selectedImageNames andbottomTitles:(NSArray *)titles withLayerCornerRadiusScale:(NSNumber *)cornerRadius;

//左图片 右label
- (instancetype) initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage rightTitle:(NSString *)rightTitle;

//上label 下lineView
/** view */
@property (nonatomic ,strong) UIView * bottomView;
- (instancetype) initWithFrame:(CGRect)frame andTitle:(NSString *)title;

//上图片 中label 底label
- (instancetype) initWithFrame:(CGRect)frame topImage:(UIImage *)topImage andMiddleTitle:(NSString *)Middletitle andBottomTitle:(NSString *)bottomTitle;

//中label 右图片
- (instancetype) initWithFrame:(CGRect)frame leftLabelTitle:(NSString *)leftLabelTitle andRightImage:(UIImage *)rightImage;


//左图右图中label
- (instancetype) initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage middleLabelTitle:(NSString *)labelTitle andRightImage:(UIImage *)rightImage;

//左图右button中label
- (instancetype) initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage middleLabelTitle:(NSString *)middleLabelTitle andRightButtonTitle:(NSString *)rightButtonTitle;

@end
