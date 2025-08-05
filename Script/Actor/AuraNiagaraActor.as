class AAuraNiagaraActor : AActor
{
    UPROPERTY(DefaultComponent, RootComponent)
    USceneComponent SceneRoot;

    UPROPERTY(DefaultComponent, Attach = SceneRoot)
    UBoxComponent Box;

    UPROPERTY(DefaultComponent, Attach = SceneRoot)
    UNiagaraComponent Niagara;

    UPROPERTY()
    TSubclassOf<UGameplayEffect> GameplayEffectClass;

    FActiveGameplayEffectHandle EffectHandle;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        check(GameplayEffectClass != nullptr);
    }

    UFUNCTION(BlueprintOverride)
    void ActorBeginOverlap(AActor OtherActor)
    {
        if (HasAuthority())
        {
            EffectHandle = AuraUtil::ApplyGameEffect(this, OtherActor, GameplayEffectClass);
        }
    }

    UFUNCTION(BlueprintOverride)
    void ActorEndOverlap(AActor OtherActor)
    {
        if (HasAuthority())
        {
            AuraUtil::RemoveGameplayEffect(OtherActor, EffectHandle);
            EffectHandle = AuraConst::EmptyEffectHandle;
        }
    }
};