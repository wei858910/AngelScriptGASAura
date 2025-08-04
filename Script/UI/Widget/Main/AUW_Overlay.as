class UAUW_Overlay : UAuraUserWidget
{
    UPROPERTY(BindWidget)
    UAUW_GlobeProgressBar WBP_GlobeHealth;

    UPROPERTY(BindWidget)
    UAUW_GlobeProgressBar WBP_GlobeMana;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
        if (IsValid(WBP_GlobeMana) && IsValid(WBP_GlobeMana.GlobeProgressBar))
        {
            FProgressBarStyle ProgressBarStyle = WBP_GlobeMana.GlobeProgressBar.WidgetStyle;
            ProgressBarStyle.FillImage.ResourceObject = LoadObject(this, "/Game/Assets/UI/Globes/MI_ManaGlobe");
            WBP_GlobeMana.GlobeProgressBar.SetWidgetStyle(ProgressBarStyle);
        }
    }
};