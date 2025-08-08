namespace WidgetUtil
{
	event void OnWidgetOpenned(UUserWidget Widget);
	event void OnWidgetClosed(TSubclassOf<UUserWidget> WidgetClass);

	UUserWidget OpenWidget(FName WidgetClassName, APlayerController PlayerController, FVector2D Position = FVector2D::ZeroVector)
	{
		TSubclassOf<UUserWidget> WidgetClass = SData::GetWidgetClass(WidgetClassName);
		if (WidgetClass == nullptr)
		{
			Print(f"Widget {WidgetClassName} is not found");
			return nullptr;
		}

		UUserWidget UserWidget = WidgetBlueprint::CreateWidget(WidgetClass, PlayerController);
		if (UserWidget == nullptr)
		{
			Print(f"Failed to create UserWidget {WidgetClassName}");
			return nullptr;
		}

		if (Position != FVector2D::ZeroVector)
		{
			UserWidget.SetPositionInViewport(Position);
		}

		UserWidget.AddToViewport();
        AuraUtil::GameInstance().EventMgr.OnWidgetOpenedEvent.Broadcast(UserWidget);

		return UserWidget;
	}

	void CloseWidget(UUserWidget ClosedWidget)
	{
		if (IsValid(ClosedWidget))
		{
            AuraUtil::GameInstance().EventMgr.OnWidgetClosedEvent.Broadcast(ClosedWidget);

			ClosedWidget.RemoveFromParent();
		}
	}

	FVector2D GetViewportPositionByRatio(APlayerController PlayerController, float32 PositionRatio)
	{
		int SizeX = 0, SizeY = 0;
		PlayerController.GetViewportSize(SizeX, SizeY);
		return FVector2D(float(SizeX) * PositionRatio, float(SizeY) * PositionRatio);
	}
} // namespace WidgetUtil