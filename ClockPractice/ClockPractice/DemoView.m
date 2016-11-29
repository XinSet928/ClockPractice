//
//  DemoView.m
//  时钟练习
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DemoView.h"

@implementation DemoView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:140 startAngle:0 endAngle:2*M_PI clockwise:0];
    
    path.lineWidth = 2;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [path stroke];
    
    //创建秒针
    second = [[CALayer alloc] init];
    second.frame = CGRectMake(0, 0, 2, 139);
    second.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    //设置锚点
    second.anchorPoint = CGPointMake(0.5, 0.9);
    second.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:second];
    
    //创建分针
    minutes = [[CALayer alloc] init];
    minutes.frame = CGRectMake(0, 0, 3, 114);
    minutes.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    minutes.anchorPoint = CGPointMake(0.5, 1);
    
    minutes.backgroundColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:minutes];
    
    //创建时针
    hours = [[CALayer alloc] init];
    hours.frame = CGRectMake(0, 0, 6, 90);
    hours.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    hours.anchorPoint = CGPointMake(0.5, 1);
    hours.backgroundColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:hours];
    
    //中心点
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:8 startAngle:0 endAngle:2*M_PI clockwise:0];
    
    path1.lineWidth = 2;
    path1.lineJoinStyle = kCGLineJoinRound;
    
    [path1 fill];
    
    
    //使用这个定时器，有很大的可能会比实际时间慢一秒钟
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(secondAction) userInfo:nil repeats:YES];
    
    //使用屏幕刷新率
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(secondAction)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self secondAction];
}

-(void)secondAction{
    
    //方法一：
    //使用NSDate
    NSDate *date = [NSDate date];
    //格式化时间对象
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"ss";//这是获取当前时间的秒
//    NSString *seconds = [formatter stringFromDate:date];
//    CGFloat secondF = [seconds floatValue];
    
    //方法二
    NSCalendar *cal = [NSCalendar currentCalendar];
    CGFloat secondF = [cal component:NSCalendarUnitSecond fromDate:date];
    CGFloat minutesF = [cal component:NSCalendarUnitMinute fromDate:date];
    CGFloat hoursF = [cal component:NSCalendarUnitHour fromDate:date];

    //扩展
    /**
     *  NSCalendarUnitYear               = kCFCalendarUnitYear,
        NSCalendarUnitMonth              = kCFCalendarUnitMonth,
        NSCalendarUnitDay
     */

    NSInteger Year = [cal component:NSCalendarUnitYear fromDate:date];
    NSInteger Month = [cal component:NSCalendarUnitMonth fromDate:date];
    NSInteger day = [cal component:NSCalendarUnitDay fromDate:date];
    NSInteger week = [cal component:NSCalendarUnitWeekdayOrdinal fromDate:date];
    
    UILabel *label = [self viewWithTag:100];
    NSString *str = [NSString stringWithFormat:@"%ld年%ld月%ld日星期%ld",Year,Month,day,week+1];
    label.text = str;
    
    
    
    
    
    //一秒钟旋转的角度
    CGFloat angle = 2*M_PI/60;
    CGFloat angleMin = 2*M_PI /60;
    CGFloat angleHours = 2*M_PI/12;
    //应该转到的角度
    angle = angle * secondF;
    angleMin = angleMin * minutesF;
    angleHours = angleHours * hoursF;
    //旋转
    second.affineTransform = CGAffineTransformMakeRotation(angle);
    minutes.affineTransform = CGAffineTransformMakeRotation(angleMin);
    hours.affineTransform = CGAffineTransformMakeRotation(angleHours);

    
    
    
}


@end
