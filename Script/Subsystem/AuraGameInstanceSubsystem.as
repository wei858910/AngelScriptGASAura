class UAuraGameInstanceSubsystem : UScriptGameInstanceSubsystem
{
    USDataMgr SDataMgr;

    UAuraEventMgr EventMgr;

    UFUNCTION(BlueprintOverride)
    void Initialize()
    {
        SDataMgr = USDataMgr();
        EventMgr = UAuraEventMgr();
        SDataMgr.Init();
    }
};