class UAUW_AttributeMenu : UAuraUserWidget
{
    // ------------------------ Bind Widgets ------------------------

    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_AttributePoints;

    // Primary Attributes
    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_Strength;

    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_Intelligence;

    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_Resislience;

    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_Vigor;

    // Secondary Attributes
    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_Armor;

    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_ArmorPenetration;

    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_BlockChance;

    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_CriticalHitChance;

    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_CriticalHitDamage;

    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_CriticalHitResistance;

    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_MaxHealth;

    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_HealthRegen;

    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_MaxMana;

    UPROPERTY(BindWidget)
    UAUW_TextValueRow WBP_ManaRegen;

    UPROPERTY(BindWidget)
    UAUW_Button WBP_Button_Close;

    // ------------------------ Functions ------------------------

    UFUNCTION(BlueprintOverride)
    void OnInitialized()
    {
        InitWidgetsInfo();
        Update();
        WBP_Button_Close.Button.OnClicked.AddUFunction(this, n"OnButton_CloseClicked");
    }

    void InitWidgetsInfo()
    {
        WBP_AttributePoints.Text_Text.SetText(FText::FromString("属性点"));
        WBP_Button_Close.Text.SetText(FText::FromString("x"));
    }

    void OnWidgetControllerSet() override
    {
        TMap<FName, UAUW_TextValueRow> PrimaryAttributeWidgets;
        PrimaryAttributeWidgets.Add(AuraAttributes::Strength, WBP_Strength);
        PrimaryAttributeWidgets.Add(AuraAttributes::Intelligence, WBP_Intelligence);
        PrimaryAttributeWidgets.Add(AuraAttributes::Resilience, WBP_Resislience);
        PrimaryAttributeWidgets.Add(AuraAttributes::Vigor, WBP_Vigor);

        TMap<FName, UAUW_TextValueRow> SecondaryAttributeWidgets;
        SecondaryAttributeWidgets.Add(AuraAttributes::Armor, WBP_Armor);
        SecondaryAttributeWidgets.Add(AuraAttributes::ArmorPenetration, WBP_ArmorPenetration);
        SecondaryAttributeWidgets.Add(AuraAttributes::BlockChance, WBP_BlockChance);
        SecondaryAttributeWidgets.Add(AuraAttributes::CriticalHitChance, WBP_CriticalHitChance);
        SecondaryAttributeWidgets.Add(AuraAttributes::CriticalHitDamage, WBP_CriticalHitDamage);
        SecondaryAttributeWidgets.Add(AuraAttributes::CriticalHitResistance, WBP_CriticalHitResistance);
        SecondaryAttributeWidgets.Add(AuraAttributes::MaxHealth, WBP_MaxHealth);
        SecondaryAttributeWidgets.Add(AuraAttributes::HealthRegen, WBP_HealthRegen);
        SecondaryAttributeWidgets.Add(AuraAttributes::MaxMana, WBP_MaxMana);
        SecondaryAttributeWidgets.Add(AuraAttributes::ManaRegen, WBP_ManaRegen);

        // Primary Attributes
        for (auto Element : PrimaryAttributeWidgets)
        {
            FName AttributeName = Element.GetKey();
            Element.GetValue().Text_Text.SetText(FText::FromString(AttributeName.ToString()));
            Element.GetValue().WBP_Button_AddPoint.SetVisibility(ESlateVisibility::Visible);
            Element.GetValue().WBP_Button_AddPoint.Button.OnClicked.AddUFunction(this, FName(f"OnButton_Add{AttributeName}Clicked"));
            if (IsValid(WidgetController) && IsValid(WidgetController.AbilitySystemComponent))
            {
                float32 AttributeValue = WidgetController.AbilitySystemComponent.GetAttributeCurrentValue(UAuraAttributeSet, AttributeName);
                Element.GetValue().WBP_FramedValue.Text_Value.SetText(FText::FromString(f"{AttributeValue:.0}"));
            }
        }

        // Secondary Attributes
        for (auto Element : SecondaryAttributeWidgets)
        {
            FName AttributeName = Element.GetKey();
            Element.GetValue().Text_Text.SetText(FText::FromString(AttributeName.ToString()));

            if (IsValid(WidgetController) && IsValid(WidgetController.AbilitySystemComponent))
            {
                float32 AttributeValue = WidgetController.AbilitySystemComponent.GetAttributeCurrentValue(UAuraAttributeSet, AttributeName);
                Element.GetValue().WBP_FramedValue.Text_Value.SetText(FText::FromString(f"{AttributeValue:.0}"));
            }
        }
    }

    UFUNCTION()
    void OnButton_AddStrengthClicked()
    {
        Print("OnButton_AddStrengthClicked");
    }

    UFUNCTION()
    void OnButton_AddIntelligenceClicked()
    {
        Print("OnButton_AddIntelligenceClicked");
    }

    UFUNCTION()
    void OnButton_AddResilienceClicked()
    {
        Print("OnButton_AddResilienceClicked");
    }

    UFUNCTION()
    void OnButton_AddVigorClicked()
    {
        Print("OnButton_AddVigorClicked");
    }

    UFUNCTION()
    private void OnButton_CloseClicked()
    {
        WidgetUtil::CloseWidget(this);
    }

    void Update()
    {
    }
};