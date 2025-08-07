namespace SData
{
    USDataMgr GetSDataMgr()
    {
        UAuraGameInstanceSubsystem Subsystem = UAuraGameInstanceSubsystem::Get();
        return Subsystem.SDataMgr;
    }

    FSDataItem GetItem(EItemID ItemID)
    {
        return GetSDataMgr().ItemMap[ItemID];

    }

    TSubclassOf<UUserWidget> GetWidgetClass(FName WidgetClassName)
    {
        FSDataWidgetClass DataWidgetClass;
        if(GetSDataMgr().WidgetClassesTable.FindRow(WidgetClassName, DataWidgetClass))
        {
            return DataWidgetClass.WidgetClass;
        }
        return nullptr;
    }

} // namespace SData