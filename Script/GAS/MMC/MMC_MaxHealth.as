class UMMC_MaxHealth : UGameplayModMagnitudeCalculation
{
    FGameplayAttribute VigorAttribute;
    FGameplayEffectAttributeCaptureDefinition VigorDef;

    UMMC_MaxHealth()
    {
        VigorAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet, n"Vigor");

        VigorDef = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet.Get(), n"Vigor", EGameplayEffectAttributeCaptureSource::Target, false);
    }

    UFUNCTION(BlueprintOverride)
    float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
    {
        FGameplayTagContainer SourceTags = Spec.GetCapturedSourceTags().AggregatedTags;
        FGameplayTagContainer TargetTags = Spec.GetCapturedTargetTags().AggregatedTags;
        float32 VigorValue = GetCapturedAttributeMagnitude(Spec, VigorAttribute, SourceTags, TargetTags);
        VigorValue = Math::Max(VigorValue, 0.f);

        int32 PlayerLevel = 1;
        AAuraCharacterBase CharacterBase = Cast<AAuraCharacterBase>(Spec.GetContext().GetSourceObject());
        if(IsValid(CharacterBase))
        {
            PlayerLevel = CharacterBase.CombatComponent.GetLevel();
        }

        return 80.f + 2.5f * VigorValue + 10.f * PlayerLevel;
    }
};