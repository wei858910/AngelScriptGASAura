class UCombatComponent : UActorComponent
{
    int32 GetLevel()
    {
        if (GetOwner().IsA(AAuraCharacter))
        {
            return Cast<AAuraCharacter>(GetOwner()).GetPlayerLevel();
        }

        if (GetOwner().IsA(AAuraEnemy))
        {
            return Cast<AAuraEnemy>(GetOwner()).GetPlayerLevel();
        }

        return 0;
    }
};