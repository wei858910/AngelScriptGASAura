class UAuraCharacterAnimInstance : UAnimInstance
{
    AAuraCharacter OwnerCharacter = nullptr;

    UPROPERTY(BlueprintReadOnly)
    float GroundSpeed = 0;

    UPROPERTY(BlueprintReadOnly)
    bool bShouldMove = false;

    UFUNCTION(BlueprintOverride)
    void BlueprintInitializeAnimation()
    {
        OwnerCharacter = Cast<AAuraCharacter>(TryGetPawnOwner());
    }

    UFUNCTION(BlueprintOverride)
    void BlueprintUpdateAnimation(float DeltaTimeX)
    {
        if (IsValid(OwnerCharacter))
        {
            GroundSpeed = OwnerCharacter.CharacterMovement.Velocity.Size2D();

            bShouldMove = GroundSpeed > 3.0 ? true : false;
        }
    }
};