#import "HighScoreModelManager.h"
#import "HighScoreModel+CoreDataClass.h"

@interface HighScoreModelManager()
@property (nonatomic) NSManagedObjectContext *context;
@end


@implementation HighScoreModelManager

-(instancetype)initWithContext:(NSManagedObjectContext*)context {
    self = [super init];
    self.context = context;
    return self;
}

-(void)insertWithEmail:(NSString*)email score:(NSString*)score stage:(NSString*)stage {
    // Criamos e inserimos um novo objecto na BD
    HighScoreModel *model = [NSEntityDescription insertNewObjectForEntityForName:@"HighScoreModel" inManagedObjectContext:self.context];
    model.email = email;
    model.score = (int)score;
    model.stage = stage;
}

-(NSArray*)fetch {
    // Criamos um NSFetchRequest para podermos obter dados da BD
    // No construtor temos que indicar o nome da entity, neste caso é o "HighScoreModel"
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"HighScoreModel"];

    // NSSortDescriptor é usado para ordenar os dados retornadas da BD
    // Neste caso estamos a ordenar pela propriedade "name"
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"email" ascending: YES];
    request.sortDescriptors = @[descriptor];

    NSError *error;
    // Vamos buscar a BD os dados com as configurações dadas no NSFetchRequest
    NSArray *highScores = [self.context executeFetchRequest:request error:&error];

    //Verificamos se houve algum erro ao tentar obter os dados
    if (error != nil) {
        NSLog(@"%@", error.localizedDescription);
    }

    //Por fim retornamos os dados obtidos
    return highScores;
}
-(NSArray <HighScoreModel *>*)fetchWithFilter:(NSString*)email stage:(NSString*)stage{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HighScoreModel"];
    NSPredicate *predicateEmail = [NSPredicate predicateWithFormat:@"email == %@",email];
    NSPredicate *predicateStage = [NSPredicate predicateWithFormat:@"age == %@", stage];
    request.predicate = predicateEmail;
    request.predicate = predicateStage;
    NSArray<HighScoreModel*>* highScores = [self.context executeFetchRequest:request error:nil];
    //[self printResultsFromArray:persons];
    return highScores;
}

@end
