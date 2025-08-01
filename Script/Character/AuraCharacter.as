class AAuraCharacter : AAuraCharacterBase
{
    UPROPERTY(DefaultComponent)
    USceneComponent Root;

    UPROPERTY(DefaultComponent, Attach = Root)
    USpringArmComponent SpringArm;

    UPROPERTY(DefaultComponent, Attach = SpringArm)
    UCameraComponent Camera;

    default SpringArm.SetRelativeRotation(FRotator(-45, 0, 0));
    default SpringArm.TargetArmLength = 750;
    default SpringArm.bUsePawnControlRotation = false;

    default CharacterMovement.bOrientRotationToMovement = true;
    default CharacterMovement.RotationRate = FRotator(0, 400, 0);
    default CharacterMovement.bConstrainToPlane = true;
    default CharacterMovement.bSnapToPlaneAtStart = true;

    default bUseControllerRotationPitch = false;
    default bUseControllerRotationYaw = false;
    default bUseControllerRotationRoll = false;
};