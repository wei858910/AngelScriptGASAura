class AAuraEffectActor : AActor
{
    UPROPERTY(DefaultComponent, RootComponent)
    UStaticMeshComponent Mesh;

    UPROPERTY(DefaultComponent, Attach = Mesh)
    USphereComponent Sphere;

    default Mesh.SetWorldScale3D(FVector(0.3, 0.3, 0.3));
    default Sphere.SetSphereRadius(137.0);

    UFUNCTION(BlueprintOverride)
    void ActorBeginOverlap(AActor OtherActor)
    {
        auto AngelscriptGASCharacter = Cast<AAngelscriptGASCharacter>(OtherActor);
        if (IsValid(AngelscriptGASCharacter))
        {
            const UAttributeSet AttributeSet = AngelscriptGASCharacter.AbilitySystem.GetAttributeSet(UAuraAttributeSet);
            UAuraAttributeSet   AuraAttributeSet = Cast<UAuraAttributeSet>(AttributeSet);
            if (IsValid(AuraAttributeSet))
            {
                AuraAttributeSet.Health.SetCurrentValue(AuraAttributeSet.Health.GetCurrentValue() + 10.0);
                DestroyActor();
            }
        }
    }
};