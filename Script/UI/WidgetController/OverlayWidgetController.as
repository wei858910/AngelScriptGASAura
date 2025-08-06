class UOverlayWidgetController : UAuraWidgetController
{
    void OnWidgetControllerParamsSet(const FWidgetControllerParams& Params) override
    {
        Super::OnWidgetControllerParamsSet(Params);
        AttributeSet.OnGameplayEffectAppliedEvent.AddUFunction(this, n"OnGameplayEffectApplied");
    }

    UFUNCTION()
    private void OnGameplayEffectApplied(FGameplayEffectSpec EffectSpec, FGameplayModifierEvaluatedData EvaluatedData, UAngelscriptAbilitySystemComponent TargetASC)
    {
        const FGameplayTagContainer TagContainer = EffectSpec.GetAllAssetTags();
        for (const FGameplayTag& Tag : TagContainer.GameplayTags)
        {
            Print(f"OnEffectApplied: {Tag.ToString()}");
        }
    }
};