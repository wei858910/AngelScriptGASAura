class UAUW_PickupMsg : UAuraUserWidget
{
    UPROPERTY(BindWidget)
    UImage PickupItem_Icon;

    UPROPERTY(BindWidget)
    UTextBlock PickupItem_Msg;

    UPROPERTY(Transient, Meta = (BindWidgetAnim), NotEditable)
    protected UWidgetAnimation Anim_FadeExit;

    UFUNCTION(BlueprintOverride)
    void OnInitialized()
    {
        if (IsValid(Anim_FadeExit))
        {
            PlayAnimation(Anim_FadeExit);
        }
    }

    UFUNCTION(BlueprintOverride)
    void OnAnimationFinished(const UWidgetAnimation Animation)
    {
        if (Animation == Anim_FadeExit)
        {
            RemoveFromParent();
        }
    }
};