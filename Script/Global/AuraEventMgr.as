event void FOnItemPickUp(EItemID ItemID);

event void FOnWidgetOpened(UUserWidget Widget);
event void FOnWidgetClosed(UUserWidget Widget);

class UAuraEventMgr : UObject
{
	FOnItemPickUp OnItemPickedUpEvent;
	FOnWidgetOpened OnWidgetOpenedEvent;
	FOnWidgetClosed OnWidgetClosedEvent;
}
