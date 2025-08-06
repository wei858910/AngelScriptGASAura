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

    // Epic suggests that only should clamp the value in PreAttributeChange,
    // don't execute complex logic in this function, eg: ApplyGameplayEffect
    UFUNCTION(BlueprintOverride)
    void PreAttributeChange(FGameplayAttribute Attribute, float32& NewValue)
    {
        if (Attribute.AttributeName == AuraAttributes::Health)
        {
            NewValue = Math::Clamp(NewValue, float32(0), MaxHealth.GetCurrentValue());
        }
        else if (Attribute.AttributeName == AuraAttributes::Mana)
        {
            NewValue = Math::Clamp(NewValue, float32(0), MaxMana.GetCurrentValue());
        }
    }

    UFUNCTION(BlueprintOverride)
    void PostGameplayEffectExecute(FGameplayEffectSpec EffectSpec, FGameplayModifierEvaluatedData& EvaluatedData, UAngelscriptAbilitySystemComponent TargetASC)
    {
        Print(f"PostGameplayEffectExecute: {EffectSpec.GetLevel()}");
        FEffectProperties Props;
        GetEffectProperties(Props, EffectSpec, TargetASC);
    }

    void GetEffectProperties(FEffectProperties& Props, FGameplayEffectSpec EffectSpec, UAngelscriptAbilitySystemComponent TargetASC)
    {
        Props.EffectContextHandle = EffectSpec.GetContext();
        Props.SourceASC = Cast<UAngelscriptAbilitySystemComponent>(Props.EffectContextHandle.GetOriginalInstigatorAbilitySystemComponent());
        RetrieveASCInfo(Props.SourceASC, Props.SourceAvatarActor, Props.SourceController, Props.SourceCharacter);
        Props.TargetASC = TargetASC;
        RetrieveASCInfo(Props.TargetASC, Props.TargetAvatarActor, Props.TargetController, Props.TargetCharacter);
    }

    void RetrieveASCInfo(UAngelscriptAbilitySystemComponent ASC, AActor& AvatarActor, AController& Controller, ACharacter& Character)
    {
        if (!IsValid(ASC))
        {
            return;
        }
        AvatarActor = ASC.GetAbilityActorInfo().GetAvatarActor();
        Controller = ASC.GetAbilityActorInfo().GetPlayerController();
        if (Controller == nullptr && AvatarActor != nullptr)
        {
            const APawn Pawn = Cast<APawn>(AvatarActor);
            if (Pawn != nullptr)
            {
                Controller = Pawn.GetController();
            }
        }
        if (Controller != nullptr)
        {
            Character = Cast<ACharacter>(Controller.GetControlledPawn());
        }
    }
};