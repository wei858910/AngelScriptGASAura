namespace WidgetControllerMgr
{
    FWidgetControllerParams GetWidgetControllerParams()
    {
        APlayerController PC = Gameplay::GetPlayerController(0);
        if (IsValid(PC))
        {
            AAuraPlayerState PS = Cast<AAuraPlayerState>(PC.PlayerState);
            AAuraCharacter AuraCharacter = Cast<AAuraCharacter>(PC.GetControlledPawn());
            UAngelscriptAbilitySystemComponent ASC;
            if (IsValid(AuraCharacter))
            {
                ASC = AuraCharacter.AbilitySystem;
                UAuraAttributeSet AS = AuraCharacter.GetAuraAttributeSet();

                return FWidgetControllerParams(PC, PS, ASC, AS);
            }
        }
        return FWidgetControllerParams();
    }

    UOverlayWidgetController GetOverlayWidgetController()
    {
        FWidgetControllerParams WidgetControllerParams = GetWidgetControllerParams();

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
        FWidgetControllerParams WidgetControllerParams = GetWidgetControllerParams();

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