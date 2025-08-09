class UMMC_MaxMana : UGameplayModMagnitudeCalculation
{
    FGameplayAttribute IntelligenceAttribute;
    FGameplayEffectAttributeCaptureDefinition IntelligenceDef;

    UMMC_MaxMana()
    {
        IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet, AuraAttributes::Intelligence);

        IntelligenceDef = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet.Get(), AuraAttributes::Intelligence, EGameplayEffectAttributeCaptureSource::Target, false);
    }

    UFUNCTION(BlueprintOverride)
    float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
    {
        FGameplayTagContainer SourceTags = Spec.GetCapturedSourceTags().AggregatedTags;
        FGameplayTagContainer TargetTags = Spec.GetCapturedTargetTags().AggregatedTags;
        float32 IntelligenceValue = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
        IntelligenceValue = Math::Max(IntelligenceValue, 0.f);

        int32 PlayerLevel = 1;
        AAuraCharacterBase CharacterBase = Cast<AAuraCharacterBase>(Spec.GetContext().GetSourceObject());
        if (IsValid(CharacterBase))
        {
            PlayerLevel = CharacterBase.CombatComponent.GetLevel();
        }

        return 50.f + 2.5f * IntelligenceValue + 15.f * PlayerLevel;
    }
};