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

    UPROPERTY(NotEditable)
    UAttributeMenuWidgetController AttributeMenuWidgetController;

    UPROPERTY()
    TSubclassOf<UAttributeMenuWidgetController> AttributeMenuWidgetControllerClass;

    UOverlayWidgetController GetOverlayWidgetController(const FWidgetControllerParams& WidgetControllerParams)
    {
        if (OverlayWidgetController == nullptr)
        {
            OverlayWidgetController = NewObject(this, OverlayWidgetControllerClass);
            if (IsValid(OverlayWidgetController))
            {
                OverlayWidgetController.SetWidgetControllerParams(WidgetControllerParams);
            }
        }
        return OverlayWidgetController;
    }

    UAttributeMenuWidgetController GetAttributeMenuWidgetController(const FWidgetControllerParams& WidgetControllerParams)
    {
        if (AttributeMenuWidgetController == nullptr)
        {
            AttributeMenuWidgetController = NewObject(this, AttributeMenuWidgetControllerClass);
            if (IsValid(AttributeMenuWidgetController))
            {
                AttributeMenuWidgetController.SetWidgetControllerParams(WidgetControllerParams);
            }
        }
        return AttributeMenuWidgetController;
    }

    void InitOverlay()
    {
        check(OverlayWidgetClass != nullptr);
        check(OverlayWidgetControllerClass != nullptr);

        OverlayWidget = Cast<UAuraUserWidget>(WidgetBlueprint::CreateWidget(OverlayWidgetClass, GetOwningPlayerController()));

        if (IsValid(OverlayWidget))
        {
            const FWidgetControllerParams WidgetControllerParams = AuraUtil::GameInstance().GetWidgetControllerParams();
            UOverlayWidgetController InWidgetController = GetOverlayWidgetController(WidgetControllerParams);
            OverlayWidget.SetWidgetController(InWidgetController);

            OverlayWidget.AddToViewport();
        }
    }
};