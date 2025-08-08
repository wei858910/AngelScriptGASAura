namespace AuraAttributes
{
    // Primary Attributes
    const FName Strength = n"Strength";         // 力量
    const FName Intelligence = n"Intelligence"; // 智力
    const FName Resilience = n"Resilience";     // 抗性
    const FName Vigor = n"Vigor";               // 精力

    // Secondary Attributes

    //  Defense Attributes
    const FName Armor = n"Armor";                       // 护甲
    const FName ArmorPenetration = n"ArmorPenetration"; // 护甲穿透
    const FName BlockChance = n"BlockChance";           // 格挡率

    //  Attack Attributes
    const FName CriticalHitChance = n"CriticalHitChance";         // 暴击率
    const FName CriticalHitDamage = n"CriticalHitDamage";         // 暴击伤害
    const FName CriticalHitResistance = n"CriticalHitResistance"; // 暴击抗性

    // Vital Attributes
    const FName Health = n"Health";
    const FName MaxHealth = n"MaxHealth";
    const FName HealthRegen = n"HealthRegen"; // 生命回复
    const FName Mana = n"Mana";
    const FName MaxMana = n"MaxMana";
    const FName ManaRegen = n"ManaRegen"; // 法力回复
} // namespace AuraAttributes

event void FOnGameplayEffectApplied(FGameplayEffectSpec EffectSpec, FGameplayModifierEvaluatedData EvaluatedData, UAngelscriptAbilitySystemComponent TargetASC);

class UAuraAttributeSet : UAngelscriptAttributeSet // 天使脚本属性集
{
    // =================================== Attributes ===================================

    // Primary Attributes
    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
    FAngelscriptGameplayAttributeData Strength;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
    FAngelscriptGameplayAttributeData Intelligence;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
    FAngelscriptGameplayAttributeData Resilience;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
    FAngelscriptGameplayAttributeData Vigor;

    // Secondary Attributes

    //  Defense Attributes
    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Defense Attributes")
    FAngelscriptGameplayAttributeData Armor;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Defense Attributes")
    FAngelscriptGameplayAttributeData ArmorPenetration;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Defense Attributes")
    FAngelscriptGameplayAttributeData BlockChance;

    //  Attack Attributes
    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Attack Attributes")
    FAngelscriptGameplayAttributeData CriticalHitChance;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Attack Attributes")
    FAngelscriptGameplayAttributeData CriticalHitDamage;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Attack Attributes")
    FAngelscriptGameplayAttributeData CriticalHitResistance;

    // Vital Attributes
    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
    FAngelscriptGameplayAttributeData Health;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
    FAngelscriptGameplayAttributeData MaxHealth;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
    FAngelscriptGameplayAttributeData HealthRegen;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
    FAngelscriptGameplayAttributeData Mana;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
    FAngelscriptGameplayAttributeData MaxMana;

    UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
    FAngelscriptGameplayAttributeData ManaRegen;

    // Varibles
    private TArray<FAngelscriptGameplayAttributeData> PrimaryAttributes;
    private TArray<FAngelscriptGameplayAttributeData> SecondaryAttributes;
    private TArray<FAngelscriptGameplayAttributeData> VitalAttributes;
    private TMap<FName, FAngelscriptGameplayAttributeData> AttributeMap;

    // ======================================================================================================

    // Events
    FOnGameplayEffectApplied OnGameplayEffectAppliedEvent;

    // Functions
    UAuraAttributeSet()
    {
        InitAttributeArray();
        InitAttributeMap();
    }

    void InitAttributeArray()
    {
        PrimaryAttributes.Add(Strength);
        PrimaryAttributes.Add(Intelligence);
        PrimaryAttributes.Add(Resilience);
        PrimaryAttributes.Add(Vigor);

        SecondaryAttributes.Add(Armor);
        SecondaryAttributes.Add(ArmorPenetration);
        SecondaryAttributes.Add(BlockChance);
        SecondaryAttributes.Add(CriticalHitChance);
        SecondaryAttributes.Add(CriticalHitDamage);
        SecondaryAttributes.Add(CriticalHitResistance);
        SecondaryAttributes.Add(MaxHealth);
        SecondaryAttributes.Add(HealthRegen);
        SecondaryAttributes.Add(MaxMana);
        SecondaryAttributes.Add(ManaRegen);

        VitalAttributes.Add(Health);
        VitalAttributes.Add(Mana);
    }

    void InitAttributeMap()
    {
        // Primary Attributes
        AttributeMap.Add(AuraAttributes::Strength, Strength);
        AttributeMap.Add(AuraAttributes::Intelligence, Intelligence);
        AttributeMap.Add(AuraAttributes::Resilience, Resilience);
        AttributeMap.Add(AuraAttributes::Vigor, Vigor);

        // Defense Attributes
        AttributeMap.Add(AuraAttributes::Armor, Armor);
        AttributeMap.Add(AuraAttributes::ArmorPenetration, ArmorPenetration);
        AttributeMap.Add(AuraAttributes::BlockChance, BlockChance);

        // Attack Attributes
        AttributeMap.Add(AuraAttributes::CriticalHitChance, CriticalHitChance);
        AttributeMap.Add(AuraAttributes::CriticalHitDamage, CriticalHitDamage);
        AttributeMap.Add(AuraAttributes::CriticalHitResistance, CriticalHitResistance);

        // Vital Attributes
        AttributeMap.Add(AuraAttributes::Health, Health);
        AttributeMap.Add(AuraAttributes::MaxHealth, MaxHealth);
        AttributeMap.Add(AuraAttributes::HealthRegen, HealthRegen);
        AttributeMap.Add(AuraAttributes::Mana, Mana);
        AttributeMap.Add(AuraAttributes::MaxMana, MaxMana);
        AttributeMap.Add(AuraAttributes::ManaRegen, ManaRegen);
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

    const TArray<FAngelscriptGameplayAttributeData>& GetPrimaryAttributes()
    {
        return PrimaryAttributes;
    }

    const TArray<FAngelscriptGameplayAttributeData>& GetSecondaryAttributes()
    {
        return SecondaryAttributes;
    }

    const TMap<FName, FAngelscriptGameplayAttributeData>& GetAllAttributes()
    {
        return AttributeMap;
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