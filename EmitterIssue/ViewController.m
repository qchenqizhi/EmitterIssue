//
//  ViewController.m
//  EmitterIssue
//
//  Created by  on 8/27/13.
//  Copyright (c) 2013 EI. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (nonatomic, strong) CAEmitterLayer *animationLayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = CGPointMake(212, self.view.bounds.size.height - 96);
    emitterLayer.emitterSize = CGSizeMake(25, 25);
    emitterLayer.emitterMode = kCAEmitterLayerOutline;
    emitterLayer.emitterShape = kCAEmitterLayerPoints;
    emitterLayer.renderMode = kCAEmitterLayerUnordered;
    emitterLayer.preservesDepth = YES;
    
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    emitterCell.name = @"bubble";
    emitterCell.contents = (id) [[UIImage imageNamed:@"bubble1"] CGImage];
    emitterCell.color = [[UIColor redColor] CGColor];
    
    emitterCell.emissionLongitude = M_PI_2 * 0.76;
    emitterCell.emissionRange = 0.6 * M_PI;
    emitterCell.emissionLatitude = M_PI / 1.0;
    emitterCell.birthRate = 0;
    emitterCell.lifetime = 7.0;
    
    emitterCell.velocity = 200;
    emitterCell.velocityRange = 60;
    emitterCell.xAcceleration = 0;
    emitterCell.yAcceleration = 16;
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    emitterCell.scale = 0.55f * scale / 2.0;
    emitterCell.scaleSpeed = -0.1 * scale / 2.0;
    emitterCell.scaleRange = 0.1 * scale / 2.0;
    emitterCell.spinRange = 1.0 * M_PI;
    
    emitterLayer.emitterCells = @[emitterCell];
    [self.view.layer addSublayer:emitterLayer];
    self.animationLayer = emitterLayer;
    
    UIButton *button = [[UIButton alloc] initWithFrame:self.view.bounds];
    [button addTarget:self action:@selector(blow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)blow
{
    CABasicAnimation *blow = [CABasicAnimation animationWithKeyPath:@"emitterCells.bubble.birthRate"];
    blow.fromValue = @40.0;
    blow.toValue = @30;
    blow.duration = 1.6;
    blow.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    blow.delegate = self;
    
    [self.animationLayer addAnimation:blow forKey:@"blow"];
}

@end
