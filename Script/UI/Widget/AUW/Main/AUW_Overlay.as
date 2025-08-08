class UAUW_Overlay : UAuraUserWidget
{
	UPROPERTY(BindWidget)
	UAUW_GlobeProgressBar WBP_GlobeHealth;

	UPROPERTY(BindWidget)
	UAUW_GlobeProgressBar WBP_GlobeMana;

	UPROPERTY(BindWidget)
	UAUW_Button WBP_WideButton_Attributes;

	TMap<FName, float32> CachedAttributeValues;

	UFUNCTION(BlueprintOverride)
	void Construct()
	{
		if (IsValid(WBP_GlobeMana) && IsValid(WBP_GlobeMana.ProgressBar_Main))

		{
			FProgressBarStyle ProgressBarStyle = WBP_GlobeMana.ProgressBar_Main.WidgetStyle;
			ProgressBarStyle.FillImage.ResourceObject = LoadObject(this, "/Game/Assets/UI/Globes/MI_ManaGlobe");
			WBP_GlobeMana.ProgressBar_Main.SetWidgetStyle(ProgressBarStyle);
		}

		if (IsValid(WBP_WideButton_Attributes))
		{
			WBP_WideButton_Attributes.Button.OnClicked.AddUFunction(this, n"OnButton_AttributesClicked");
			AuraUtil::GameInstance().EventMgr.OnWidgetClosedEvent.AddUFunction(this, n"OnAttributeMenuClosed");

		}
	}

	UFUNCTION()
	private void OnButton_AttributesClicked()
	{
		UAUW_AttributeMenu AttributeMenu = Cast<UAUW_AttributeMenu>(WidgetUtil::OpenWidget(n"AttributeMenu", WidgetController.PlayerController, FVector2D(30.f, 30.f)));
		if (IsValid(AttributeMenu))
		{
			AttributeMenu.SetWidgetController(WidgetController);
			WBP_WideButton_Attributes.SetIsEnabled(false);
		}
	}

	UFUNCTION()
	private void OnAttributeMenuClosed(UUserWidget Widget)
	{
		if (Widget.IsA(UAUW_AttributeMenu))
		{
			WBP_WideButton_Attributes.SetIsEnabled(true);
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

			WBP_GlobeHealth.SetPercent(Health, MaxHealth);
		}

		if (IsValid(WBP_GlobeMana))
		{
			float32 Mana = GetAttributeValue(AuraAttributes::Mana);
			float32 MaxMana = GetAttributeValue(AuraAttributes::MaxMana);

			WBP_GlobeMana.SetPercent(Mana, MaxMana);
		}
	}
};