// Copyright Druid Mechanics

#include "AuraPlayerControllerBase.h"

void AAuraPlayerControllerBase::AcknowledgePossession(APawn* P)
{
    Super::AcknowledgePossession(P);
    BP_OnAcknowledgePossession(P);
}