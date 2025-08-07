class USDataMgr : UObject
{
    TMap<EItemID, FSDataItem> ItemMap;

    UDataTable WidgetClassesTable;

    void Init()
    {
        UDataTable SDataItems = Cast<UDataTable>(LoadObject(this, "/Game/SData/DT_SData_Item.DT_SData_Item"));

        TArray<FSDataItem> AllItems;
        SDataItems.GetAllRows(AllItems);
        for (FSDataItem Item : AllItems)
        {
            ItemMap.Add(Item.ItemID, Item);
        }

        WidgetClassesTable = Cast<UDataTable>(LoadObject(this, "/Game/SData/DT_SData_WidgetClass.DT_SData_WidgetClass"));
    }
};
