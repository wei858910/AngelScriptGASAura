class UAuraEnmyAnimInstance : UAnimInstance
{
    AAuraEnemy OwnerCharacter = nullptr;

    UPROPERTY(BlueprintReadOnly)
    float GroundSpeed = 0;

    UFUNCTION(BlueprintOverride)
    void BlueprintInitializeAnimation()
    {
        OwnerCharacter = Cast<AAuraEnemy>(TryGetPawnOwner());
    }

    UFUNCTION(BlueprintOverride)
    void BlueprintUpdateAnimation(float DeltaTimeX)
    {
        if (IsValid(OwnerCharacter))
        {
            GroundSpeed = OwnerCharacter.CharacterMovement.Velocity.Size2D();
        }
    }
};