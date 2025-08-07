class AAuraEffectActor : AActor
{
    UPROPERTY(DefaultComponent, RootComponent)
    UStaticMeshComponent Mesh;

    UPROPERTY(DefaultComponent, Attach = Mesh)
    USphereComponent Sphere;

    default Mesh.SetWorldScale3D(FVector(0.3, 0.3, 0.3));
    default Sphere.SetSphereRadius(137.0);

    // The ID of the item. Configured in the DataTable DT_SData_Item
    UPROPERTY()
    EItemID ItemID;

    // The level of the actor, used to determine the level of the gameplay effect
    UPROPERTY()
    float32 ActorLevel = 1;

    UFUNCTION(BlueprintOverride)
    void ActorBeginOverlap(AActor OtherActor)
    {
        if (HasAuthority())
        {
            FSDataItem DataItem = SData::GetItem(ItemID);
            AuraUtil::ApplyGameEffect(this, OtherActor, DataItem.GameplayEffectClass, ActorLevel);

            DestroyActor();
        }
        UAuraGameInstanceSubsystem::Get().EventMgr.OnItemPickedUpEvent.Broadcast(ItemID);
        DestroyActor();
    }
};