//
//  ViewController.m
//  TransformDemo
//
//  Created by 惠上科技 on 2019/2/22.
//  Copyright © 2019 惠上科技. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *a_view;
@property (nonatomic, strong) UIView *b_view;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) BOOL once;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self cgAffineFransfrom];
    
    [self caTransform3D];
    
//    [self sublayerTransform];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.once) {
        [UIView animateWithDuration:2.0 animations:^{
//            self.a_view.transform = CGAffineTransformMakeRotation(M_PI_4/2);
            
//            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.5, 0.5);
//            self.a_view.transform = CGAffineTransformRotate(scaleTransform,M_PI_4/2);
        }];
        self.once = NO;
    }else{
        [UIView animateWithDuration:2.0 animations:^{
            self.a_view.transform = CGAffineTransformMakeScale(0.5, 0.5);
            
//            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.5, 0.5);
//            CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(M_PI_4/2);
//            self.b_view.transform = CGAffineTransformConcat(scaleTransform, rotateTransform);
            
//            CGAffineTransform tranform = CGAffineTransformIdentity;
//            tranform = CGAffineTransformScale(tranform, 0.5, 0.5);
//            tranform = CGAffineTransformRotate(tranform, M_PI_4);
//            tranform = CGAffineTransformTranslate(tranform, 200, 0);
//            self.a_view.transform = tranform;
        }];
        self.once = YES;
    }
}


-(void)cgAffineFransfrom{
    self.once = YES;
    self.a_view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.a_view.backgroundColor = [UIColor redColor];
//    self.a_view.layer.anchorPoint = CGPointZero;
    [self.view addSubview:self.a_view];
    
    
//    self.b_view = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
//    self.b_view.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:self.b_view];
}



-(void)caTransform3D{
//    CATransform3D transform3D = CATransform3DIdentity;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    transform3D.m34 = -1/500.0;
//    transform3D = CATransform3DRotate(transform3D, M_PI, 0, 1, 0);
//    imageView.layer.transform = transform3D;
//    imageView.layer.doubleSided = NO;//图层背面是否被绘制
    self.label.text = @"223232";
    self.label.backgroundColor = [UIColor redColor];
    self.label.userInteractionEnabled = YES;
//    self.imageView.image = [UIImage imageNamed:@"1111"];
    [self.view addSubview:self.label];
    
    
    UITapGestureRecognizer *imageOneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOne)];
    imageOneTap.numberOfTapsRequired = 1;
    [self.label addGestureRecognizer:imageOneTap];
    
    UITapGestureRecognizer *imageTwoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwo)];
    imageTwoTap.numberOfTapsRequired = 2;
    [self.label addGestureRecognizer:imageTwoTap];
    
}

//单击
-(void)tapOne{
    self.label.layer.transform = [self performVerticalFlipInClockwiseDirection:YES];
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations: ^{
        self.label.layer.transform = CATransform3DIdentity;
    }completion: ^(BOOL finished) {
    }];
}

//双击
-(void)tapTwo{
    self.label.layer.transform = [self performVerticalFlipInClockwiseDirection:YES];
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations: ^{
        self.label.layer.transform = CATransform3DIdentity;
    }completion: ^(BOOL finished) {
    }];
}

-(CATransform3D)performVerticalFlipInClockwiseDirection:(BOOL)clockwise{
    return [self getTransformForIndex:1 inClockwiseDirection:clockwise];
}

- (CATransform3D)getTransformForIndex:(int)index inClockwiseDirection:(BOOL)clockwise {
    int direction = clockwise ? -1 : 1;
    float xCord = index ? 1.0 : 0.0;
    float yCord = index ? 0.0 : 1.0;
    float zCord = 0.0;
    //float angle = (180 * direction) * (M_PI / 180);
    float angle = direction * M_PI;
    CGPoint offset = CGPointMake(0, 0);
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, angle, xCord, yCord, zCord);
    transform = CATransform3DTranslate(transform, offset.x, offset.y, 0.0);
    return transform;
}


-(void)sublayerTransform{
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView1.image = [UIImage imageNamed:@"1111"];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
    imageView2.image = imageView1.image;
    
    UIView *containtsView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    containtsView.backgroundColor = [UIColor grayColor];
    [containtsView addSubview:imageView1];
    [containtsView addSubview:imageView2];
    
    //应用sublayerTransform
    CATransform3D transformv = CATransform3DIdentity;
    transformv.m34 = -1.0/500.0;
    containtsView.layer.sublayerTransform = transformv;
    
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    imageView2.layer.transform = transform2;
    imageView1.layer.transform = transform1;
    
    [self.view addSubview:containtsView];
}


@end
