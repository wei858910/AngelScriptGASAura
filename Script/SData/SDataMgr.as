class USDataMgr : UObject
{
    private TMap<EItemID, FSDataItem> ItemMap;

    void Init()
    {
        UDataTable SDataItems = Cast<UDataTable>(LoadObject(this, "/Game/SData/DT_SData_Item.DT_SData_Item"));

        TArray<FSDataItem> AllItems;
        SDataItems.GetAllRows(AllItems);
        for (FSDataItem Item : AllItems)
        {
            ItemMap.Add(Item.ItemID, Item);
        }
    }

    FSDataItem GetItem(EItemID ItemID)
    {
        return ItemMap[ItemID];
    }
};

namespace SData
{
    USDataMgr GetDataMgr()
    {
        UAuraGameInstanceSubsystem Subsystem = UAuraGameInstanceSubsystem::Get();
        return Subsystem.SDataMgr;
    }

    FSDataItem GetItem(EItemID ItemID)
    {
        return GetDataMgr().GetItem(ItemID);
    }

} // namespace SData