namespace AuraAttributes
{
    // Primary Attributes
    const FName Strength = n"Strength";       // 力量
    const FName Intellignce = n"Intellignce"; // 智力
    const FName Resilience = n"Resilience";   // 抗性
    const FName Vigor = n"Vigor";             // 精力

    // Vital Attributes
    const FName Health = n"Health";
    const FName MaxHealth = n"MaxHealth";
    const FName Mana = n"Mana";
    const FName MaxMana = n"MaxMana";
} // namespace AuraAttributes

event void FOnGameplayEffectApplied(FGameplayEffectSpec EffectSpec, FGameplayModifierEvaluatedData EvaluatedData, UAngelscriptAbilitySystemComponent TargetASC);

class UAuraAttributeSet : UAngelscriptAttributeSet // 天使脚本属性集
{
    // =================================== Attributes ===================================

    // Primary Attributes
    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
    FAngelscriptGameplayAttributeData Strength;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
    FAngelscriptGameplayAttributeData Intellignce;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
    FAngelscriptGameplayAttributeData Resilience;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
    FAngelscriptGameplayAttributeData Vigor;

    // Vital Attributes
    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
    FAngelscriptGameplayAttributeData Health;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
    FAngelscriptGameplayAttributeData MaxHealth;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
    FAngelscriptGameplayAttributeData Mana;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
    FAngelscriptGameplayAttributeData MaxMana;

    TMap<FName, FAngelscriptGameplayAttributeData> AttributeMap;

    // Events
    FOnGameplayEffectApplied OnGameplayEffectAppliedEvent;

    // Functions
    UAuraAttributeSet()
    {
        AttributeMap.Add(AuraAttributes::Strength, Strength);
        AttributeMap.Add(AuraAttributes::Intellignce, Intellignce);
        AttributeMap.Add(AuraAttributes::Resilience, Resilience);
        AttributeMap.Add(AuraAttributes::Vigor, Vigor);

        AttributeMap.Add(AuraAttributes::Health, Health);
        AttributeMap.Add(AuraAttributes::MaxHealth, MaxHealth);
        AttributeMap.Add(AuraAttributes::Mana, Mana);
        AttributeMap.Add(AuraAttributes::MaxMana, MaxMana);
    }

    UFUNCTION()
    void OnRep_ReplicationTrampoline(FAngelscriptGameplayAttributeData& OldAttributeData)
    {
        OnRep_Attribute(OldAttributeData);
    }

    FAngelscriptGameplayAttributeData& GetAttribute(FName AttributeName)
    {
        if (AttributeMap.Contains(AttributeName))
        {
            return AttributeMap[AttributeName];
        }

        check(false);
        return Health;
    }

    // Epic suggests that only should clamp the value in PreAttributeChange,
    // don't execute complex logic in this function, eg: ApplyGameplayEffect
    UFUNCTION(BlueprintOverride)
    void PreAttributeChange(FGameplayAttribute Attribute, float32& NewValue)
    {
        ClampAttribute(Attribute, NewValue);
    }

    void ClampAttribute(FGameplayAttribute Attribute, float32& NewValue)
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
        auto& AttributeData = GetAttribute(FName(EvaluatedData.GetAttribute().AttributeName));
        float32 BaseValue = AttributeData.GetBaseValue();
        ClampAttribute(EvaluatedData.GetAttribute(), BaseValue);

        if (BaseValue != AttributeData.GetBaseValue())
        {
            AttributeData.SetBaseValue(BaseValue);
        }

        Print(f"PostGameplayEffectExecute: {EffectSpec.GetLevel()}");
        FEffectProperties Props;
        GetEffectProperties(Props, EffectSpec, TargetASC);

        // This event is broadcasted by OnGameplayEffectAppliedDelegateToSelf.Brocast() in the course.
        // Because there is no OnGameplayEffectAppliedDelegateToSelf in the Angelscript, so I just call this function via PostGameplayEffectExecute.
        OnGameplayEffectAppliedEvent.Broadcast(EffectSpec, EvaluatedData, TargetASC);
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