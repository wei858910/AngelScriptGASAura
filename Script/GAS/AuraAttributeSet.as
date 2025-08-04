namespace AuraAttributes
{
    const FName Health = n"Health";
    const FName MaxHealth = n"MaxHealth";
    const FName Mana = n"Mana";
    const FName MaxMana = n"MaxMana";
} // namespace AuraAttributes

class UAuraAttributeSet : UAngelscriptAttributeSet // 天使脚本属性集
{
    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "重要属性")
    FAngelscriptGameplayAttributeData Health; // 天使脚本游戏属性数据

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "重要属性")
    FAngelscriptGameplayAttributeData MaxHealth;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "重要属性")
    FAngelscriptGameplayAttributeData Mana;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "重要属性")
    FAngelscriptGameplayAttributeData MaxMana;

    UAuraAttributeSet()
    {
        Health.Initialize(100);
        MaxHealth.Initialize(100);
        Mana.Initialize(50);
        MaxMana.Initialize(50);
    }

    UFUNCTION()
    void OnRep_ReplicationTrampoline(FAngelscriptGameplayAttributeData& OldAttributeData)
    {
        OnRep_Attribute(OldAttributeData);
    }

    const FAngelscriptGameplayAttributeData& GetAttribute(FName AttributeName)
    {
        if (AttributeName == AuraAttributes::Health)
            return Health;
        if (AttributeName == AuraAttributes::MaxHealth)
            return MaxHealth;
        if (AttributeName == AuraAttributes::Mana)
            return Mana;
        if (AttributeName == AuraAttributes::MaxMana)
            return MaxMana;
        check(false);
        return Health;
    }
};