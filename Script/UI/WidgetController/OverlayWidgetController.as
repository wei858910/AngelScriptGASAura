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
        UAuraEventMgr EventMgr = UAuraGameInstanceSubsystem::Get().EventMgr;
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

        TSubclassOf<UUserWidget> WidgetClass = SData::GetWidgetClass(n"PickupMsg");

        auto PickupMsgWidget = Cast<UAUW_PickupMsg>(WidgetBlueprint::CreateWidget(WidgetClass, PlayerController));
        if (PickupMsgWidget == nullptr)
        {
            Print("Failed to create PickupMsgWidget");
            return;
        }

        PickupMsgWidget.PickupItem_Icon.SetBrushFromTexture(DataItem.Icon);
        FText Text = FText::FromString(f"Picked up a {DataItem.Name}");
        PickupMsgWidget.PickupItem_Msg.SetText(Text);
        int SizeX = 0, SizeY = 0;
        PlayerController.GetViewportSize(SizeX, SizeY);
        PickupMsgWidget.SetPositionInViewport(FVector2D(float(SizeX) / 2, float(SizeY) / 2));
        PickupMsgWidget.AddToViewport();
    }
};