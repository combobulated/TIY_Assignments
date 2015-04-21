// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Listitem.m instead.

#import "_Listitem.h"

const struct ListitemAttributes ListitemAttributes = {
	.item = @"item",
};

@implementation ListitemID
@end

@implementation _Listitem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Listitem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Listitem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Listitem" inManagedObjectContext:moc_];
}

- (ListitemID*)objectID {
	return (ListitemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic item;

@end

