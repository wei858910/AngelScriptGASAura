class AAuraCharacterBase : AAngelscriptGASCharacter
{
    UPROPERTY(DefaultComponent, Category = "Combat", Attach = CharacterMesh0, AttachSocket = WeaponHandSocket)
    USkeletalMeshComponent Weapon;

    default Weapon.SetCollisionEnabled(ECollisionEnabled::NoCollision);

    UPROPERTY(Category = "Attributes")
    TSubclassOf<UGameplayEffect> AuraPrimaryEffectClass;

    void InitializePrimaryAttributes()
    {
        if (IsValid(AuraPrimaryEffectClass))
        {
            AuraUtil::ApplyGameEffect(this, this, AuraPrimaryEffectClass, 1);
        }
    }
};