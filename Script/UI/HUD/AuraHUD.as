class AAuraHUD : AHUD
{
    UPROPERTY(NotEditable)
    UAuraUserWidget OverlayWidget;

    UPROPERTY()
    TSubclassOf<UAuraUserWidget> OverlayWidgetClass;

    UPROPERTY(NotEditable)
    UOverlayWidgetController OverlayWidgetController;

    UPROPERTY()
    TSubclassOf<UOverlayWidgetController> OverlayWidgetControllerClass;

    UOverlayWidgetController GetOverlayWidgetController(const FWidgetControllerParams& WidgetControllerParams)
    {
        if (OverlayWidgetController == nullptr)
        {
            OverlayWidgetController = NewObject(this, OverlayWidgetControllerClass);
            if (IsValid(OverlayWidgetController))
            {
                OverlayWidgetController.InitWidgetController(WidgetControllerParams);
            }
        }
        return OverlayWidgetController;
    }

    void InitOverlay(APlayerController PlayerController, APlayerState PlayerState, UAngelscriptAbilitySystemComponent AbilitySystemComponent, UAuraAttributeSet AttributeSet)
    {
        check(OverlayWidgetClass != nullptr);
        check(OverlayWidgetControllerClass != nullptr);

        OverlayWidget = Cast<UAuraUserWidget>(WidgetBlueprint::CreateWidget(OverlayWidgetClass, GetOwningPlayerController()));

        if (IsValid(OverlayWidget))
        {
            const FWidgetControllerParams WidgetControllerParams(PlayerController, PlayerState, AbilitySystemComponent, AttributeSet);
            UOverlayWidgetController InWidgetController = GetOverlayWidgetController(WidgetControllerParams);
            OverlayWidget.SetWidgetController(InWidgetController);

            OverlayWidget.AddToViewport();
        }
    }
};