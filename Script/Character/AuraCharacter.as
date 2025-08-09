class AAuraCharacter : AAuraCharacterBase
{
    UPROPERTY(DefaultComponent)
    USpringArmComponent SpringArm;

    UPROPERTY(DefaultComponent, Attach = SpringArm)
    UCameraComponent Camera;

    UPROPERTY(VisibleAnywhere, ReplicatedUsing = OnRep_Level)
    int32 Level = 1; // 角色等级

    default Camera.bUsePawnControlRotation = false;

    default SpringArm.SetRelativeRotation(FRotator(-45, 0, 0));
    default SpringArm.TargetArmLength = 750;
    default SpringArm.bUsePawnControlRotation = false;

    // 禁用SpringArm继承父节点的旋转属性，确保相机视角独立于角色旋转
    default SpringArm.bInheritPitch = false;
    default SpringArm.bInheritYaw = false;
    default SpringArm.bInheritRoll = false;

    default CharacterMovement.bOrientRotationToMovement = true;
    default CharacterMovement.RotationRate = FRotator(0, 400, 0);
    default CharacterMovement.bConstrainToPlane = true;
    default CharacterMovement.bSnapToPlaneAtStart = true;

    default bUseControllerRotationPitch = false;
    default bUseControllerRotationYaw = false;
    default bUseControllerRotationRoll = false;

    default AbilitySystem.SetIsReplicated(true);

    default AbilitySystem.SetReplicationMode(EGameplayEffectReplicationMode::Mixed);

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
    }

    UFUNCTION(BlueprintOverride)
    void Possessed(AController NewController)
    {
        AbilitySystem.InitAbilityActorInfo(this, this);
        AbilitySystem.RegisterAttributeSet(UAuraAttributeSet);
    }

    UFUNCTION(Server)
    void Server_InitializeAttributesByGameplayEffects()
    {
        InitializePrimaryAttributes();
        InitializeSecondaryAttributes();
        InitializeVitalAttributes();
    }

    UFUNCTION()
    void OnRep_Level(int32 OldLevel)
    {
    }

    int32 GetPlayerLevel()
    {
        return Level;
    }
};