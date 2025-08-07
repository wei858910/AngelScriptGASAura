enum EItemID
{
    None,
    HealthPotion,
    ManaPotion,
    HealthCrystal,
    ManaCrystal
}

USTRUCT()
struct FSDataItem
{
    UPROPERTY()
    EItemID ItemID;

    UPROPERTY()
    FName Name;

    UPROPERTY()
    UTexture2D Icon;

    // The Gameplay Effect which will be applied when the item is used or picked up
    UPROPERTY()
    TSubclassOf<UGameplayEffect> GameplayEffectClass;
}