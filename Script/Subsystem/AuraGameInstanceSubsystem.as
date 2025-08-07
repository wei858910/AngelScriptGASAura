class UAuraGameInstanceSubsystem : UScriptGameInstanceSubsystem
{
    USDataMgr SDataMgr;

    UFUNCTION(BlueprintOverride)
    void Initialize()
    {
        SDataMgr = USDataMgr();
        SDataMgr.Init();
    }
};