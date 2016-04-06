//
//  TQWDouBanMovieUSBox.h
//  TMTime
//
//  Created by 涂清文 on 16/4/2.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TQWUSBoxSubjects,TQWUSBoxSubjectsSubject,TQWUSBoxSubjectsSubjectImages,TQWUSBoxSubjectsSubjectRating,TQWUSBoxSubjectsSubjectCasts,TQWUSBoxSubjectsSubjectCastsAvatars,TQWUSBoxSubjectsSubjectDirectors,TQWUSBoxSubjectsSubjectCastsAvatars;
@interface TQWDouBanMovieUSBox : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, strong) NSArray<TQWUSBoxSubjects *> *subjects;

@property (nonatomic, copy) NSString *title;

@end



@interface TQWUSBoxSubjects : NSObject

@property (nonatomic, assign) NSInteger box;

@property (nonatomic, assign) BOOL new;

@property (nonatomic, strong) TQWUSBoxSubjectsSubject *subject;

@property (nonatomic, assign) NSInteger rank;

@end

@interface TQWUSBoxSubjectsSubject : NSObject

@property (nonatomic, strong) TQWUSBoxSubjectsSubjectRating *rating;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *original_title;

@property (nonatomic, assign) NSInteger collect_count;

@property (nonatomic, strong) NSArray<TQWUSBoxSubjectsSubjectDirectors *> *directors;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *year;

@property (nonatomic, strong) NSArray<TQWUSBoxSubjectsSubjectCasts *> *casts;

@property (nonatomic, strong) NSArray<NSString *> *genres;

@property (nonatomic, strong) TQWUSBoxSubjectsSubjectImages *images;

@property (nonatomic, copy) NSString *subtype;

@property (nonatomic, copy) NSString *alt;

@end

@interface TQWUSBoxSubjectsSubjectImages : NSObject

@property (nonatomic, copy) NSString *small;

@property (nonatomic, copy) NSString *large;

@property (nonatomic, copy) NSString *medium;

@end

@interface TQWUSBoxSubjectsSubjectRating : NSObject

@property (nonatomic, copy) NSString *stars;

@property (nonatomic, assign) CGFloat average;

@property (nonatomic, assign) NSInteger min;

@property (nonatomic, assign) NSInteger max;

@end

@interface TQWUSBoxSubjectsSubjectCasts : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *alt;

@property (nonatomic, strong) TQWUSBoxSubjectsSubjectCastsAvatars *avatars;

@property (nonatomic, copy) NSString *name;

@end

@interface TQWUSBoxSubjectsSubjectCastsAvatars : NSObject

@property (nonatomic, copy) NSString *small;

@property (nonatomic, copy) NSString *large;

@property (nonatomic, copy) NSString *medium;

@end

@interface TQWUSBoxSubjectsSubjectDirectors : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *alt;

@property (nonatomic, strong) TQWUSBoxSubjectsSubjectCastsAvatars *avatars;

@property (nonatomic, copy) NSString *name;

@end



