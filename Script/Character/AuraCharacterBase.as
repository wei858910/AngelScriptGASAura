class AAuraCharacterBase : AAngelscriptGASCharacter
{
    UPROPERTY(DefaultComponent)
    UCombatComponent CombatComponent;
    
    UPROPERTY(DefaultComponent, Category = "Combat", Attach = CharacterMesh0, AttachSocket = WeaponHandSocket)
    USkeletalMeshComponent Weapon;

    default Weapon.SetCollisionEnabled(ECollisionEnabled::NoCollision);

    UPROPERTY(Category = "Attributes")
    TSubclassOf<UGameplayEffect> DefaultPrimaryAttributes;

    UPROPERTY(Category = "Attributes")
    TSubclassOf<UGameplayEffect> DefaultSecondaryAttributes;

    UPROPERTY(Category = "Attributes")
    TSubclassOf<UGameplayEffect> DefaultVitalAttributes;

    void InitializePrimaryAttributes()
    {
        if (IsValid(DefaultPrimaryAttributes))
        {
            AuraUtil::ApplyGameEffect(this, this, DefaultPrimaryAttributes, 1);
        }
    }

    void InitializeSecondaryAttributes()
    {
        if (IsValid(DefaultSecondaryAttributes))
        {
            AuraUtil::ApplyGameEffect(this, this, DefaultSecondaryAttributes);
        }
    }

    void InitializeVitalAttributes()
    {
        if (IsValid(DefaultVitalAttributes))
        {
            AuraUtil::ApplyGameEffect(this, this, DefaultVitalAttributes, CombatComponent.GetLevel());
        }
    }

};