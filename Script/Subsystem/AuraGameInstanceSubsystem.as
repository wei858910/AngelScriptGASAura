class UAuraGameInstanceSubsystem : UScriptGameInstanceSubsystem
{
    USDataMgr SDataMgr;

    UAuraEventMgr EventMgr;

    FWidgetControllerParams WidgetControllerParams;

    UFUNCTION(BlueprintOverride)
    void Initialize()
    {
        SDataMgr = USDataMgr();
        EventMgr = UAuraEventMgr();
        SDataMgr.Init();
    }

    void SetWidgetControllerParams(APlayerController PlayerController, APlayerState PlayerState, UAngelscriptAbilitySystemComponent AbilitySystemComponent, UAuraAttributeSet AttributeSet)
    {
        WidgetControllerParams = FWidgetControllerParams(PlayerController, PlayerState, AbilitySystemComponent, AttributeSet);
    }

    FWidgetControllerParams GetWidgetControllerParams()
    {
        return WidgetControllerParams;
    }
};