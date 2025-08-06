class AAuraEnemy : AAuraCharacterBase
{
    int32 CUSTOM_DEPTH_RED = 250;

    default Mesh.SetCollisionResponseToChannel(ECollisionChannel::ECC_Visibility, ECollisionResponse::ECR_Block);

    default AbilitySystem.SetIsReplicated(true);
    default AbilitySystem.SetReplicationMode(EGameplayEffectReplicationMode::Minimal);

    void Hightlight()
    {
        Mesh.SetRenderCustomDepth(true);
        // Mesh.SetCustomDepthStencilValue(CUSTOM_DEPTH_RED);
        Weapon.SetRenderCustomDepth(true);
        // Mesh.SetCustomDepthStencilValue(CUSTOM_DEPTH_RED);
    }

    void UnHightlight()
    {
        Mesh.SetRenderCustomDepth(false);
        Weapon.SetRenderCustomDepth(false);
    }

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        AbilitySystem.InitAbilityActorInfo(this, this);
    }
};