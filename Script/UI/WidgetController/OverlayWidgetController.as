class UOverlayWidgetController : UAuraWidgetController
{
	void OnWidgetControllerParamsSet(const FWidgetControllerParams& Params) override
	{
		Super::OnWidgetControllerParamsSet(Params);
		AttributeSet.OnGameplayEffectAppliedEvent.AddUFunction(this, n"OnGameplayEffectApplied");

		RegisterAllWidgetEvent();
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

	void RegisterAllWidgetEvent()
	{
		UAuraEventMgr EventMgr = AuraUtil::GameInstance().EventMgr;

		EventMgr.OnItemPickedUpEvent.AddUFunction(this, n"OnItemPickedUp");
	}

	UFUNCTION()
	private void OnItemPickedUp(EItemID ItemID)
	{
		FSDataItem DataItem = SData::GetItem(ItemID);
		if (DataItem.ItemID == EItemID::None)
		{
			Print(f"OnItemPickedUp: {ItemID}");
			return;
		}

		FVector2D Position = WidgetUtil::GetViewportPositionByRatio(PlayerController, 0.5);
		UAUW_PickupMsg AUW_PickupMsg = Cast<UAUW_PickupMsg>(WidgetUtil::OpenWidget(n"PickupMsg", PlayerController, Position));
		if (IsValid(AUW_PickupMsg))
		{
			AUW_PickupMsg.PickupItem_Icon.SetBrushFromTexture(DataItem.Icon);
			FText PickupMsg = FText::FromString(f"拾取 {DataItem.Name}");
			AUW_PickupMsg.PickupItem_Msg.SetText(PickupMsg);
			AUW_PickupMsg.AddToViewport();
		}
	}
};