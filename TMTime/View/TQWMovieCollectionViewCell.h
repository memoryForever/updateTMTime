//
//  TQWMovieCollectionViewCell.h
//  TMTime
//
//  Created by 涂清文 on 16/4/3.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQWMovieCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *movieRatingLabel;
@property (weak, nonatomic) IBOutlet UIView *movieTypeLogoView;
@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;

@end
