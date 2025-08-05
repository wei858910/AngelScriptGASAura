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
        if (HasAuthority())
        {
            AuraUtil::ApplyGameEffect(this, OtherActor, GameplayEffectClass);
            DestroyActor();
        }

        DestroyActor();
    }
};