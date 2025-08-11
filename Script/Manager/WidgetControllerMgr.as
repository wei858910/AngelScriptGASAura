namespace WidgetControllerMgr
{
    UOverlayWidgetController GetOverlayWidgetController()
    {
        FWidgetControllerParams WidgetControllerParams = AuraUtil::GameInstance().GetWidgetControllerParams();

        APlayerController PC = Gameplay::GetPlayerController(0);
        if (IsValid(PC))
        {
            AAuraHUD AuraHUD = Cast<AAuraHUD>(PC.GetHUD());
            if (IsValid(AuraHUD))
            {
                return AuraHUD.GetOverlayWidgetController(WidgetControllerParams);
            }
        }

        return nullptr;
    }

    UAttributeMenuWidgetController GetAttributeMenuWidgetController()
    {
        FWidgetControllerParams WidgetControllerParams = AuraUtil::GameInstance().GetWidgetControllerParams();

        APlayerController PC = Gameplay::GetPlayerController(0);
        if (IsValid(PC))
        {
            AAuraHUD AuraHUD = Cast<AAuraHUD>(PC.GetHUD());
            if (IsValid(AuraHUD))
            {
                return AuraHUD.GetAttributeMenuWidgetController(WidgetControllerParams);
            }
        }

        return nullptr;
    }
} // namespace WidgetControllerMgr