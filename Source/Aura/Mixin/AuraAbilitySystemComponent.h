#pragma once

#include "CoreMinimal.h"
#include "AbilitySystemComponent.h"
#include "UObject/Object.h"

#include "AuraAbilitySystemComponent.generated.h"

UCLASS(Meta = (ScriptMixin = "UAbilitySystemComponent"))
class AURA_API UAngelScriptProgressBar : public UObject
{
    GENERATED_BODY()

    public:
    UFUNCTION(ScriptCallable)
    static void SetReplicationMode(UAbilitySystemComponent* ASC, const EGameplayEffectReplicationMode NewReplicationMode)
    {
        ASC->SetReplicationMode(NewReplicationMode);
    }
};