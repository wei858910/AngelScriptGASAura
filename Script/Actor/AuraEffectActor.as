class AAuraEffectActor : AActor
{
    UPROPERTY(DefaultComponent, RootComponent)
    UStaticMeshComponent Mesh;

    UPROPERTY(DefaultComponent, Attach = Mesh)
    USphereComponent Sphere;

    default Mesh.SetWorldScale3D(FVector(0.3, 0.3, 0.3));
    default Sphere.SetSphereRadius(137.0);

    UPROPERTY()
    TSubclassOf<UGameplayEffect> GameplayEffectClass;

    UFUNCTION(BlueprintOverride)
    void ActorBeginOverlap(AActor OtherActor)
    {
        UAbilitySystemComponent OtherAbilitySystemComponent = AbilitySystem::GetAbilitySystemComponent(OtherActor);
        if (IsValid(OtherAbilitySystemComponent))
        {
            check(GameplayEffectClass != nullptr, "GameplayEffectClass 没有初始化，请在编辑器中进行设置!");
            FGameplayEffectContextHandle EffectContextHandle = OtherAbilitySystemComponent.MakeEffectContext();
            EffectContextHandle.AddSourceObject(this);
            FGameplayEffectSpecHandle EffectSpecHandle = OtherAbilitySystemComponent.MakeOutgoingSpec(GameplayEffectClass, -1, EffectContextHandle);
            OtherAbilitySystemComponent.ApplyGameplayEffectSpecToSelf(EffectSpecHandle);
            DestroyActor();
        }
    }
};