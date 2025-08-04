// Copyright Druid Mechanics

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/PlayerController.h"
#include "AuraPlayerControllerBase.generated.h"

/**
 * 
 */
UCLASS()
class AURA_API AAuraPlayerControllerBase : public APlayerController
{
    GENERATED_BODY()

    public:
    virtual void AcknowledgePossession(APawn* P) override;

    UFUNCTION(BlueprintImplementableEvent)
    void BP_OnAcknowledgePossession(APawn* P);

};