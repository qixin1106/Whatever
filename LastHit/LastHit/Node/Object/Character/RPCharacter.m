//
//  RPCharacter.m
//  LastHit
//
//  Created by Qixin on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPCharacter.h"
#import "RPHpBarNode.h"
#import "RPFriendHero.h"
@interface RPCharacter ()
@end

@implementation RPCharacter


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self)
    {
        self.zPosition = CHARACTER_LAYER;
        self.position = CGPointMake(frame.origin.x, frame.origin.y);
        self.size = CGSizeMake(frame.size.width, frame.size.height);
//        [self showViewRangeLine];
//        [self showAtkRangeLine];
    }
    return self;
}


- (void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    self.hpBarNode.position = CGPointMake(-self.size.width*0.5,
                                          self.size.height*0.5+5);
}

#pragma mark - Find target
/*!
 *  寻找视野内的目标,如果没有目标,update每次都会调用,遍历所有目标,比对出最近的一个,进行锁定.
 *
 *  @param name  目标Node的name,用来遍历
 *
 *  @since 1.0
 */
- (void)findTargetWithName:(NSString*)name
{
    //check target over distance
    if (self.target)
    {
        CGFloat distance = [RPComFunction getDistanceWithYourPosition:self.position
                                                       targetPosition:self.target.position];
        if (self.viewRange<distance)
        {
            [self changeTarget:nil];
        }
    }
    //find target
    if (!self.target&&self.state!=States_Move)
    {
        __block RPCharacter *nearCharacter;
        __block CGFloat nearDistance = self.viewRange;
        [self.scene enumerateChildNodesWithName:name usingBlock:^(SKNode *node, BOOL *stop) {
            RPCharacter *character = (RPCharacter*)node;
            CGFloat distance = [RPComFunction getDistanceWithYourPosition:self.position
                                                           targetPosition:character.position];
            if (nearDistance>distance)
            {
                nearDistance = distance;
                nearCharacter = character;
            }
        }];

        if (nearDistance<=self.viewRange && nearCharacter)
        {
            //discover target
            [self changeTarget:nearCharacter];
        }
        else
        {
            //Can't attack
            [self changeState:States_Find];
            [self changeTarget:nil];
        }
    }
}


#pragma mark - Move
/*!
 *  像目标移动,如果目标存在并且角色状态是Move
 *
 *  @since 1.0
 */
- (void)moveToTarget
{
    if (self.target)
    {
        CGFloat distance = [RPComFunction getDistanceWithYourPosition:self.position
                                                       targetPosition:self.target.position];
        if (self.state == States_Find)
        {
            SKAction *run = [SKAction moveTo:self.target.position duration:distance/self.moveSpeed];
            [self runAction:run];
        }

        if (distance<=self.atkRange)
        {
            //can attack
            [self changeState:States_Atk];
        }
        else
        {
            //can move to target
            [self changeState:States_Find];
        }
    }
}

/*!
 *  移动Node,该方法会改变状态为States_Move,该状态下属于强制移动,并取消target,移动结束后继续寻找目标
 *
 *  @param point 移动到该点
 *
 *  @since 1.0
 */
- (void)moveToPoint:(CGPoint)point
{
    [self changeState:States_Move];
    [self changeTarget:nil];
    CGFloat distance = [RPComFunction getDistanceWithYourPosition:self.position
                                                   targetPosition:point];
    self.zRotation = [RPComFunction getRadianWithYourPosition:self.position
                                               targetPosition:point];
    SKAction *run = [SKAction moveTo:point duration:distance/self.moveSpeed];
    [self runAction:run completion:^{
        [self changeState:States_Find];
    }];
}






#pragma mark - The subclass implementation
/*!
 *  子类节点的名字,用来做目标遍历查找
 *
 *  @return 节点名字
 *
 *  @since 1.0
 */
+ (NSString*)getNodeName{return nil;}
- (void)attackTarget{}


#pragma mark - Change state
/*!
 *  改变状态
 *
 *  @param state 状态枚举,请在头文件查看
 *
 *  @since 1.0
 */
- (void)changeState:(States)state
{
    if (self.state!=state)
    {
        self.state=state;
        [self removeAllActions];
        switch (self.state)
        {
            case States_Atk:
            {
                NSLog(@"[%@]呕哼~~(豺狼人)",self.nickname);
                break;
            }
            case States_Dead:
            {
                NSLog(@"[%@]祖国万岁",self.nickname);
                self.target = nil;
                [self removeFromParent];
                break;
            }
            case States_Find:
            {
                NSLog(@"[%@]为了部落",self.nickname);
                break;
            }
            case States_Stop:
            {
                NSLog(@"[%@]Stop",self.nickname);
                break;
            }
            case States_Move:
            {
                NSLog(@"[%@]Work Work",self.nickname);
                break;
            }
            default:
                break;
        }
    }
}


#pragma mark - Change target
/*!
 *  改变目标
 *
 *  @param target 目标对象,如果赋值nil则视为丢失目标
 *
 *  @since 1.0
 */
- (void)changeTarget:(RPCharacter *)target
{
    if (self.target != target)
    {
        self.target = target;
    }
    if (!self.target)
    {
        [self removeAllActions];
    }
}


#pragma mark - Change HP
/*!
 *  改变血量,并判断自身血量是否低于0(死亡)
 *
 *  @param curHp  改变后的血量,并非是伤害量,这个值将直接覆盖当前血量
 *  @param sender 攻击者对象(以后可能会有治疗,暂时忽略)
 *
 *  @since 1.0
 */
- (void)changeCurHp:(CGFloat)curHp byObj:(RPCharacter *)sender
{
    if (self.curHp != curHp && self.curHp>0)
    {
        self.curHp = (curHp<0)?0:curHp;
        
        //refresh HpBar
        if (self.hpBarNode)
        {
            //NSLog(@"[%@] HP:%.0f/%.0f(%.2f%%)",self.nickname,self.curHp,self.maxHp,(self.curHp/self.maxHp)*100);
            [self.hpBarNode changeWidthWithHpRate:self.curHp/self.maxHp];
        }
       
        //low hp alert
        if (![RPComFunction isHpSafe:self])
        {
            //NSLog(@"[%@]要死了,要死了,要死了",self.nickname);
        }
       
        //dead
        if (self.curHp<=0)
        {
            //Dead
            [self changeState:States_Dead];
            //change sender state
            [sender changeTarget:nil];
            //remove HP Bar
            [self.hpBarNode removeFromParent];
            //get gold
            if ([sender isKindOfClass:[RPFriendHero class]])
            {
                NSLog(@"获得金钱");
            }
        }
        
    }
}


#pragma mark - Update
/*!
 *  刷新节点
 *
 *  @param currentTime Scene刷新时间
 *
 *  @since 1.0
 */
- (void)update:(NSTimeInterval)currentTime
{
    //change state if not target and state is not Move
    if (!self.target && self.state!=States_Move)
    {
        [self changeState:States_Find];
    }
    
    //contrl atk
    if (currentTime-self.lastTime>self.atkInterval)
    {
        //fire
        [self attackTarget];
        self.lastTime = currentTime;
    }

    //control direction
    if (self.target)
    {
        self.zRotation = [RPComFunction getRadianWithYourPosition:self.position
                                                   targetPosition:self.target.position];
    }

    //move
    [self moveToTarget];

}



#pragma mark - Debug
/*!
 *  Debug用显示视野范围
 *
 *  @since 1.0
 */
- (void)showViewRangeLine
{
#ifdef DEBUG
    SKShapeNode *viewRangeLine = [SKShapeNode node];
    viewRangeLine.strokeColor = RGB(255, 255, 255);
    viewRangeLine.lineWidth = 1.0f;
    viewRangeLine.alpha = 0.5f;

    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                            radius:self.viewRange
                                                        startAngle:M_PI
                                                          endAngle:-M_PI
                                                         clockwise:YES];
    viewRangeLine.path = ovalPath.CGPath;
    [self addChild:viewRangeLine];
#endif
}

/*!
 *  Debug用显示射程范围
 *
 *  @since 1.0
 */
- (void)showAtkRangeLine
{
#ifdef DEBUG
    SKShapeNode *atkRangeLine = [SKShapeNode node];
    atkRangeLine.strokeColor = RGB(255, 0, 0);
    atkRangeLine.lineWidth = 1.0f;
    atkRangeLine.alpha = 0.5f;

    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                            radius:self.atkRange
                                                        startAngle:M_PI
                                                          endAngle:-M_PI
                                                         clockwise:YES];
    atkRangeLine.path = ovalPath.CGPath;
    [self addChild:atkRangeLine];
#endif
}
@end

