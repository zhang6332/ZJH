//
//  ZJHDrawRectView.m
//  apple
//
//  Created by apple on 16/11/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZJHLineView.h"
#define SEPARATE_LINE_COLOR [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f]
#define DATA_TEXT_COLOR [UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f]
#define ZHEXIAN_COLOR [UIColor colorWithRed:1.00f green:0.36f blue:0.00f alpha:1.00f]
#define START_HEIGHT 30
#define START_WIDTH 0
@interface ZJHLineView ()

@property (nonatomic ,strong) NSMutableArray * dataArray;
@property (nonatomic ,strong) NSMutableArray * dateArray;

@end
@implementation ZJHLineView

- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)dataArray andDateArray:(NSArray *)dateArray {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataArray = [NSMutableArray arrayWithArray:dataArray];
        self.dateArray = [NSMutableArray arrayWithArray:dateArray];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    self.backgroundColor = [UIColor whiteColor];
    //label的宽
    double labelWidth = self.frame.size.width / self.dateArray.count;
    double labelHeight = 30;
    double maxData = [[self.dataArray valueForKeyPath:@"@max.floatValue"] floatValue];
    double minData = [[self.dataArray valueForKeyPath:@"@min.floatValue"] floatValue];
    //标注大小
    double num = (maxData - minData) / (self.dateArray.count - 1);
    //刻度大小
    double cen = (self.frame.size.height - START_HEIGHT - labelHeight - labelHeight / 2) / (maxData - minData);
    
    for (int i = 0; i < self.dateArray.count; i++) {
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelWidth, labelHeight)];
        label.center = CGPointMake(START_WIDTH + labelWidth / 2, START_HEIGHT + label.frame.size.height / 2 + (self.frame.size.height - (START_HEIGHT + labelHeight + labelHeight / 2)) / (self.dateArray.count - 1) * i);
        label.text = [NSString stringWithFormat:@"%.3f",maxData - num * i];
        label.textColor = DATA_TEXT_COLOR;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 9860 + i;
        [self addSubview:label];
        //画线横向颜色
        [SEPARATE_LINE_COLOR set];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(CGRectGetMaxX(label.frame), label.center.y)];
        [path addLineToPoint:CGPointMake(self.frame.size.width - labelWidth / 2, label.center.y)];
        path.lineWidth     = 0.5;
        path.lineCapStyle  = kCGLineCapRound;
        path.lineJoinStyle = kCGLineCapRound;
        [path stroke];
        
       
    }
    
    for (int i = 0; i < self.dateArray.count; i++) {
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelWidth, labelHeight)];
        label.center = CGPointMake(START_WIDTH + labelWidth + (self.frame.size.width - START_WIDTH - labelWidth / 2 - labelWidth) / (self.dateArray.count - 1) * i, self.frame.size.height - labelHeight / 2);
        label.text = self.dateArray[self.dateArray.count- 1 - i];
        label.textColor = DATA_TEXT_COLOR;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        //画竖线颜色
        [SEPARATE_LINE_COLOR set];
        UIBezierPath *path1 = [UIBezierPath bezierPath];
        [path1 moveToPoint:CGPointMake(label.center.x, START_HEIGHT + labelHeight / 2)];
        [path1 addLineToPoint:CGPointMake(label.center.x, CGRectGetMinY(label.frame))];
        path1.lineWidth     = 0.5;
        path1.lineCapStyle  = kCGLineCapRound;
        path1.lineJoinStyle = kCGLineCapRound;
        [path1 stroke];
        
    }
    
    
    //画折线
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
         CGPoint point = CGPointMake(labelWidth + (self.frame.size.width - labelWidth - labelWidth / 2) / (self.dateArray.count - 1) * i,START_HEIGHT + labelHeight / 2 + (maxData - [self.dataArray[i] floatValue]) * cen);
        
        if ([self.dataArray[i] floatValue] == maxData) {
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
            label.clipsToBounds = YES;
            label.layer.cornerRadius = 3;
            label.center = CGPointMake(point.x, point.y - label.frame.size.height);
            label.backgroundColor = [UIColor colorWithRed:0.97f green:0.46f blue:0.29f alpha:1.00f];
            label.text = [NSString stringWithFormat:@"%.3f",[self.dataArray[i] floatValue]] ;
            label.textColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];;
            label.font = [UIFont systemFontOfSize:15];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            
        }
        
        
        
        
            if (i == 0) {
            
                [path1 moveToPoint:point];

            }else {
                
                [path1 addLineToPoint:point];
                
                
                UIBezierPath * aPath = [UIBezierPath bezierPathWithArcCenter:point radius:5 startAngle:0 endAngle:2 * 3.14 clockwise:YES];
                
                aPath.lineWidth = 1;
                aPath.lineCapStyle = kCGLineCapRound; //线条拐角
                aPath.lineJoinStyle = kCGLineCapRound; //终点处理
                
                [[UIColor whiteColor]setFill];
                [[UIColor colorWithRed:1.00f green:0.36f blue:0.00f alpha:1.00f] setStroke];
                
                [aPath stroke];
                [aPath fill];
            
                //小圆
                UIBezierPath * Path = [UIBezierPath bezierPathWithArcCenter:point radius:2 startAngle:0 endAngle:2 * 3.14 clockwise:YES];
                
                Path.lineWidth = 1;
                Path.lineCapStyle = kCGLineCapRound; //线条拐角
                Path.lineJoinStyle = kCGLineCapRound; //终点处理
                
                [[UIColor colorWithRed:1.00f green:0.36f blue:0.00f alpha:1.00f] setFill];
                
                [Path stroke];
                [Path fill];
                
            }
        
        }

    path1.lineCapStyle = kCGLineCapRound;
    path1.lineJoinStyle = kCGLineJoinRound;
    path1.lineWidth = 1.5;
    
    UIColor *strokeColor = ZHEXIAN_COLOR;
    [strokeColor set];
    
    [path1 stroke];
}


- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    return _dataArray;
}


- (NSMutableArray *)dateArray {
    
    if (_dateArray == nil) {
        
        _dateArray = [[NSMutableArray alloc]init];
        
    }
    return _dateArray;
}


@end
