class UAUW_Overlay : UAuraUserWidget
{
    UPROPERTY(BindWidget)
    UAUW_GlobeProgressBar WBP_GlobeHealth;

    UPROPERTY(BindWidget)
    UAUW_GlobeProgressBar WBP_GlobeMana;

    TMap<FName, float32> CachedAttributeValues;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
        if (IsValid(WBP_GlobeMana) && IsValid(WBP_GlobeMana.GlobeProgressBar))
        {
            FProgressBarStyle ProgressBarStyle = WBP_GlobeMana.GlobeProgressBar.WidgetStyle;
            ProgressBarStyle.FillImage.ResourceObject = LoadObject(this, "/Game/Assets/UI/Globes/MI_ManaGlobe");
            WBP_GlobeMana.GlobeProgressBar.SetWidgetStyle(ProgressBarStyle);
        }
    }

    void OnWidgetControllerSet() override
    {
        check(WidgetController.AbilitySystemComponent != nullptr);
        WidgetController.AbilitySystemComponent.OnAttributeSetRegistered(this, n"OnAuraAttributeSetRegistered");
    }

    UFUNCTION()
    private void OnAuraAttributeSetRegistered(UAngelscriptAttributeSet NewAttributeSet)
    {
        if (NewAttributeSet.IsA(UAuraAttributeSet))
        {
            WidgetController.AbilitySystemComponent.OnAttributeChanged.AddUFunction(this, n"OnAuraAttributeChanged");
            WidgetController.AbilitySystemComponent.RegisterCallbackForAttribute(UAuraAttributeSet, AuraAttributes::Health);
            WidgetController.AbilitySystemComponent.RegisterCallbackForAttribute(UAuraAttributeSet, AuraAttributes::MaxHealth);
            WidgetController.AbilitySystemComponent.RegisterCallbackForAttribute(UAuraAttributeSet, AuraAttributes::Mana);
            WidgetController.AbilitySystemComponent.RegisterCallbackForAttribute(UAuraAttributeSet, AuraAttributes::MaxMana);
        }

        UpdateWidgets();
    }

    UFUNCTION()
    private void OnAuraAttributeChanged(const FAngelscriptModifiedAttribute&in AttributeChangeData)
    {
        CachedAttributeValues.Add(AttributeChangeData.Name, AttributeChangeData.NewValue);
        UpdateWidgets();
    }

    float32 GetAttributeValue(FName AttributeName)
    {
        if (CachedAttributeValues.Contains(AttributeName))
        {
            return CachedAttributeValues[AttributeName];
        }

        return WidgetController.AttributeSet.GetAttribute(AttributeName).GetCurrentValue();
    }

    void UpdateWidgets()
    {
        if (IsValid(WBP_GlobeHealth))
        {
            float32 Health = GetAttributeValue(AuraAttributes::Health);
            float32 MaxHealth = GetAttributeValue(AuraAttributes::MaxHealth);

            WBP_GlobeHealth.GlobeProgressBar.SetPercent(AuraUtil::SafeDivide(Health, MaxHealth));
        }

        if (IsValid(WBP_GlobeMana))
        {
            float32 Mana = GetAttributeValue(AuraAttributes::Mana);
            float32 MaxMana = GetAttributeValue(AuraAttributes::MaxMana);

            WBP_GlobeMana.GlobeProgressBar.SetPercent(AuraUtil::SafeDivide(Mana, MaxMana));
        }
    }
};