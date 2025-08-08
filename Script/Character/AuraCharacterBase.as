class AAuraCharacterBase : AAngelscriptGASCharacter
{
    UPROPERTY(DefaultComponent, Category = "Combat", Attach = CharacterMesh0, AttachSocket = WeaponHandSocket)
    USkeletalMeshComponent Weapon;

    default Weapon.SetCollisionEnabled(ECollisionEnabled::NoCollision);

    UPROPERTY(Category = "Attributes")
    TSubclassOf<UGameplayEffect> DefaultPrimaryAttributes;

    UPROPERTY(Category = "Attributes")
    TSubclassOf<UGameplayEffect> DefaultSecondaryAttributes;

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
            AuraUtil::ApplyGameEffect(this, this, DefaultSecondaryAttributes, 1);
        }
    }

};